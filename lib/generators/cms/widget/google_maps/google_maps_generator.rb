module Cms
  module Generators
    module Widget
      class GoogleMapsGenerator < ::Rails::Generators::Base
        include Migration

        class_option :example,
          type: :boolean,
          default: false,
          desc: 'Create an example migration',
          banner: 'EXAMPLE'

        source_root File.expand_path('../templates', __FILE__)

        def create_migration
          begin
            validate_attribute(map_type_attribute_name)

            Rails::Generators.invoke(
              'cms:attribute',
              [
                map_type_attribute_name,
                '--type=enum',
                '--title=Map Type',
                '--values=ROADMAP',
                'SATELLITE',
                'HYBRID',
                'TERRAIN',
                '--method_name=map_type'
              ]
            )
          rescue Cms::Generators::DuplicateResourceError
          end

          begin
            validate_attribute(address_attribute_name)

            Rails::Generators.invoke(
              'cms:attribute',
              [
                address_attribute_name,
                '--type=string',
                '--title=Address',
                '--method_name=address'
              ]
            )
          rescue Cms::Generators::DuplicateResourceError
          end

          begin
            validate_obj_class(map_class_name)

            Rails::Generators.invoke(
              'cms:model',
              [
                map_class_name,
                "--attributes=#{map_type_attribute_name}",
                address_attribute_name,
                '--title=Widget: GoogleMaps'
              ]
            )
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

        def add_example
          if example?
            migration_template('example_migration.rb', 'cms/migrate/create_google_maps_widget_example.rb')
          end
        end

        private

        def example?
          options[:example]
        end

        def map_class_name
          'GoogleMapsWidget'
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