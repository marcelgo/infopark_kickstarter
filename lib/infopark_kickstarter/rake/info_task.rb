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

          desc 'Gathers important system information'
          task system_info: :environment do |_, args|
            system_info
          end

          namespace :info do
            desc 'Get information about all object classes in the given workspace (default "published")'
            task :obj_classes, [:workspace] => :environment do |_, args|
              args.with_defaults(workspace: 'published')

              puts obj_class_information(args[:workspace]).to_yaml
            end

            desc 'Get information about all permalinks in the given workspace (default "published")'
            task :permalinks, [:workspace] => :environment do |_, args|
              args.with_defaults(workspace: 'published')

              puts permalinks(args[:workspace]).to_yaml
            end
          end
        end
      end

      private

      def system_info
        puts ''
        puts 'System Component Versions'
        puts '----------------------'
        puts "Ruby Version: #{ruby_version}"
        puts "Gem Version: #{gem_version}"
        puts "Ruby on Rails Version: #{rails_gem_version}"
        puts "Infopark Kickstarter Version: #{infopark_gem_version}"
        puts "Infopark RailsConnector Version: #{infopark_rails_connector_version}"
        puts "Infopark CloudConnector Version: #{infopark_cloud_connector_version}"
        puts "Infopark CrmConnector Version: #{infopark_crm_connector_version}"

        puts ''
        puts 'CMS Structure Information'
        puts '-------------------------'
        puts obj_class_information('published').to_yaml
      end

      def ruby_version
        %x{ruby -v}
      end

      def gem_version
        %x{gem -v}
      end

      def rails_gem_version
        gem_version_for('rails')
      end

      def infopark_gem_version
        gem_version_for('infopark_kickstarter')
      end

      def infopark_rails_connector_version
        gem_version_for('infopark_rails_connector')
      end

      def infopark_cloud_connector_version
        gem_version_for('infopark_cloud_connector')
      end

      def infopark_crm_connector_version
        gem_version_for('infopark_crm_connector')
      end

      def gem_version_for(name)
        gemspec = Gem.latest_spec_for(name)

        if gemspec
          gemspec.version.to_s
        end
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

      def permalinks(workspace)
        RailsConnector::Workspace.find(workspace).as_current do
          objs = Obj.
            where(:_permalink, :is_greater_than, ' ').
            order(:_permalink).
            to_a

          objs.inject({}) do |permalinks, obj|
            permalinks[obj[:_permalink]] = obj[:_path]

            permalinks
          end
        end
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