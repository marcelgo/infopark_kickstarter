module Cms
  module Generators
    module Widget
      class GoogleMapsGenerator < ::Rails::Generators::Base
        include Migration
        include BasePaths

        class_option :example,
          type: :boolean,
          default: false,
          desc: 'Create an example migration'

        source_root File.expand_path('../templates', __FILE__)

        def create_migration
          begin
            Model::ApiGenerator.new(behavior: behavior) do |model|
              model.name = obj_class_name
              model.title = 'Widget: GoogleMaps'
              model.attributes = [
                {
                  name: address_attribute_name,
                  type: :string,
                  title: 'Address',
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

          template('thumbnail.html.haml', 'app/widgets/google_maps_widget/thumbnail.html.haml')
        end

        def add_example
          if example?
            migration_template('example_migration.rb', 'cms/migrate/create_google_maps_widget_example.rb')
          end
        end

        def notice
          if behavior == :invoke
            log(:migration, 'Make sure to run "rake cms:migrate" to apply CMS changes')
          end
        end

        private

        def example?
          options[:example]
        end

        def obj_class_name
          'GoogleMapsWidget'
        end

        def address_attribute_name
          'address'
        end

        def sort_key_attribute_name
          'sort_key'
        end
      end
    end
  end
end