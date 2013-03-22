require 'rake'
require 'rake/tasklib'
require 'launchy'
require 'net/http'
require 'json'

module InfoparkKickstarter
  module Rake
    class InfoTask < ::Rake::TaskLib
      def initialize
        namespace :cms do
          desc 'Open the Infopark console in your web browser'
          task :console do
            Launchy.open('https://console.infopark.net')
          end

          desc 'Get status information of all Infopark services'
          task :status do
            status
          end

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

      def status
        uri = URI('http://status.infopark.net/services.json')
        response = Net::HTTP.get(uri)
        json = JSON.parse(response)

        service_status = {
          'Elastic Web Platform' => 'up and running',
          'CMS' => 'up and running',
          'WebCRM' => 'up and running',
        }

        now = Time.now.strftime("%Y-%m-%d")

        if json.has_key?(now)
          json[now].each do |service, info|
            service_status[service] = info['description']
          end
        end

        service_status.each do |service, status|
          puts "  #{service}: #{status}"
        end
      end
    end
  end
end