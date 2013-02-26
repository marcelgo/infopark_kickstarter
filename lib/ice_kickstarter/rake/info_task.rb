require 'rake'
require 'rake/tasklib'

module IceKickstarter
  module Rake
    class InfoTask < ::Rake::TaskLib
      def initialize
        namespace :cms do
          namespace :info do
            desc 'Get information about all object classes in the given workspace (default "published")'
            task :obj_classes, [:workspace] => :environment do |_, args|
              args.with_defaults(workspace: 'published')

              puts obj_class_information(args[:workspace]).to_yaml
            end

            desc 'Get information about all attributes in the given workspace (default "published")'
            task :attributes, [:workspace] => :environment do |_, args|
              args.with_defaults(workspace: 'published')

              puts attribute_information(args[:workspace]).to_yaml
            end
          end
        end
      end

      private

      def obj_class_information(workspace)
        RailsConnector::Workspace.find(workspace).as_current do
          obj_classes.inject({}) do |attributes, obj_class|
            attributes[obj_class.name] = attribute_names(obj_class)

            attributes
          end
        end
      end

      def attribute_names(obj_class)
        obj_class.attributes.map(&:name).join(', ').presence
      end

      def obj_classes
        Dashboard::ObjClass.all
      end

      def attribute_information(workspace)
        RailsConnector::Workspace.find(workspace).as_current do
          attributes.inject({}) do |attributes, attribute|
            attributes[attribute.name] = attribute.type

            attributes
          end
        end
      end

      def attributes
        Dashboard::Attribute.all
      end
    end
  end
end