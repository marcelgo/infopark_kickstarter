module Cms
  module Generators
    module Widget
      class GoogleMapsGenerator < ::Rails::Generators::Base
        include Migration

        class_option :cms_path,
          type: :string,
          default: nil,
          desc: 'CMS parent path where the example box should be placed under.',
          banner: 'LOCATION'

        source_root File.expand_path('../templates', __FILE__)

        def create_migration
          begin
            Model::ApiGenerator.new(behavior: behavior) do |model|
              model.name = pin_class_name
              model.title = 'GoogleMaps: Pin'
              model.attributes = [
                {
                  name: address_attribute_name,
                  type: :string,
                  title: 'Address',
                }
              ]
            end
          rescue Cms::Generators::DuplicateResourceError
          end

          begin
            Model::ApiGenerator.new(behavior: behavior) do |model|
              model.name = map_class_name
              model.title = 'Box: GoogleMaps'
              model.attributes = [
                {
                  name: map_type_attribute_name,
                  type: :enum,
                  title: 'Map Type',
                  values: %w(ROADMAP SATELLITE HYBRID TERRAIN),
                },
                {
                  name: sort_key_attribute_name,
                  type: :string,
                  title: 'Sort key',
                }
              ]
            end
          rescue Cms::Generators::DuplicateResourceError
          end
        end

        def copy_app_directory
          directory('app', force: true)
          directory('spec', force: true)
        end

        def update_routes
          route('resources :google_maps, only: [:show]')
        end

        def update_application_layout
          file = 'app/views/layouts/application.html.haml'
          insert_point = "= javascript_include_tag('application')\n"

          data = []

          data << "    = javascript_include_tag('http://maps.google.com/maps/api/js?sensor=false')"

          data = data.join("\n")

          insert_into_file(file, data, after: insert_point)
        end

        def update_application_js
          file = 'app/assets/javascripts/application.js'

          data = []

          data << ''
          data << ''
          data << '$(document).ready(function() {'
          data << "  new GoogleMap.App('.google_maps .map');"
          data << '});'

          data = data.join("\n")

          append_file(file) do
            data
          end
        end

        def add_example
          if example?
            migration_template('example_migration.rb', 'cms/migrate/create_box_google_maps_example.rb')
          end
        end

        def add_geocoder_gem
          gem('geocoder')

          Bundler.with_clean_env do
            run('bundle --quiet')
          end
        end

        def notice
          if behavior == :invoke
            log(:migration, 'Make sure to run "rake cms:migrate" to apply CMS changes')
          end
        end

        private

        def example?
          cms_path.present?
        end

        def cms_path
          options[:cms_path]
        end

        def map_class_name
          'BoxGoogleMaps'
        end

        def pin_class_name
          'GoogleMapsPin'
        end

        def address_attribute_name
          'google_maps_address'
        end

        def map_type_attribute_name
          'google_maps_map_type'
        end

        def sort_key_attribute_name
          'sort_key'
        end
      end
    end
  end
end