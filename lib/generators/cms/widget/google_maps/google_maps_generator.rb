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
            validate_attribute(map_type_attribute_name)

            Rails::Generators.invoke('cms:attribute', [map_type_attribute_name, '--type=enum', '--title=Map Type', '--values=ROADMAP', 'SATELLITE', 'HYBRID', 'TERRAIN'])
          rescue Cms::Generators::DuplicateResourceError
          end

          begin
            validate_attribute(address_attribute_name)

            Rails::Generators.invoke('cms:attribute', [address_attribute_name, '--type=string', '--title=Address'])
          rescue Cms::Generators::DuplicateResourceError
          end

          begin
            validate_obj_class(pin_class_name)

            Rails::Generators.invoke('cms:model', [pin_class_name, "--attributes=#{address_attribute_name}", '--title=GoogleMaps: Pin'])
          rescue Cms::Generators::DuplicateResourceError
          end

          begin
            validate_obj_class(map_class_name)

            Rails::Generators.invoke('cms:model', [map_class_name, "--attributes=#{map_type_attribute_name}", address_attribute_name, '--title=Box: GoogleMaps'])
          rescue Cms::Generators::DuplicateResourceError
          end

          if behavior == :invoke
            log(:migration, 'Make sure to run "rake cms:migrate" to apply CMS changes')
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
          insert_point = "//= require infopark_rails_connector"

          data = []

          data << ''
          data << ''
          data << '$(document).ready(function() {'
          data << "  new GoogleMap.App('.google_maps .map');"
          data << '});'

          data = data.join("\n")

          insert_into_file(file, data, after: insert_point)
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
      end
    end
  end
end