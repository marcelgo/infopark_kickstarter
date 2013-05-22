require 'rake'
require 'rake/tasklib'
require 'launchy'
require 'net/http'
require 'json'

module InfoparkKickstarter
  module Rake
    class SystemInfo < ::Rake::TaskLib
      def initialize
        namespace :cms do
          namespace :system_info do

            desc 'Print important informations to the console for a quick help from the infopark support team'
            task :support , [] => :environment do |_, args|
              puts ''
              puts 'System Component Versions'
              puts '----------------------'
              puts "Ruby Version: #{ruby_version}"
              puts "Gem Version: #{gem_version}"
              puts "Ruby on Rails Version: #{rails_gem_version}"
              puts "Infopark Kickstarter Version: #{infopark_gem_version}"
              puts "Infopark RailsConnector Version: #{infopark_rails_connector_version}"
              puts "Infopark CloudConnector Version: #{infopark_cloud_connector_version}"

              puts ''
              puts 'obj class informations'
              puts '----------------------'
              puts obj_class_information('published').to_yaml
            end
          end
        end
      end

      private

      def ruby_version
        RUBY_VERSION
      end

      def gem_version
        %x{gem -v}
      end

      def rails_gem_version
        Gem.latest_spec_for('rails').version.to_s rescue ''
      end

      def infopark_gem_version
        Gem.latest_spec_for('infopark_kickstarter').version.to_s rescue ''
      end

      def infopark_rails_connector_version
        Gem.latest_spec_for('infopark_rails_connector').version.to_s rescue ''
      end

      def infopark_cloud_connector_version
        Gem.latest_spec_for('infopark_cloud_connector').version.to_s rescue ''
      end

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
    end
  end
end