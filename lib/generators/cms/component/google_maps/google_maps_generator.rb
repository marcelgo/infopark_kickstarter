require 'generators/cms/migration'

module Cms
  module Generators
    module Component
      class GoogleMapsGenerator < ::Rails::Generators::Base
        include Migration

        class_option :cms_path,
          type: :string,
          default: nil,
          desc: 'CMS parent path where the example box should be placed under.',
          banner: 'LOCATION'

        source_root File.expand_path('../templates', __FILE__)

        def copy_app_directory
          directory('app')
          directory('spec')
        end

        def create_migration
          validate_obj_class(map_class_name)
          validate_obj_class(pin_class_name)

          validate_attribute(map_type_attribute_name)
          validate_attribute(address_attribute_name)

          migration_template('migration.rb', 'cms/migrate/create_google_maps.rb')

          if behavior == :invoke
            log(:migration, 'Make sure to run "rake cms:migrate" to apply CMS changes')
          end
        rescue Cms::Generators::DuplicateResourceError
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
            migration_template('example_migration.rb', 'cms/migrate/create_google_maps_example.rb')
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