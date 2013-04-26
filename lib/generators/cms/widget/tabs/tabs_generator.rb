module Cms
  module Generators
    module Widget
      class TabsGenerator < ::Rails::Generators::Base
        include Migration
        include BasePaths
        include Actions

        class_option :cms_path,
          type: :string,
          default: nil,
          desc: 'CMS parent path where the example widget should be placed.',
          banner: 'LOCATION'

        source_root File.expand_path('../templates', __FILE__)

        def create_migration
          begin
            Model::ApiGenerator.new(behavior: behavior) do |model|
              model.name = obj_class_name
              model.title = 'Box: Tabs'
              model.attributes = [
                {
                  name: sort_key_attribute_name,
                  type: :string,
                  title: 'Sort key',
                },
              ]
            end
            turn_model_into_widget(obj_class_name, model_path)

            Model::ApiGenerator.new(behavior: behavior) do |model|
              model.name = tab_class_name
              model.title = 'Tab'
              model.attributes = [
                {
                  name: sort_key_attribute_name,
                  type: :string,
                  title: 'Sort key',
                },
              ]
            end
          rescue Cms::Generators::DuplicateResourceError
          end
        end

        def copy_app_directory
          directory('app', force: true)
        end

        def add_example
          if example?
            migration_template('example_migration.rb', 'cms/migrate/create_box_tabs_example.rb')
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

        def model_path
          'app/models'
        end

        def cms_path
          options[:cms_path]
        end

        def obj_class_name
          'BoxTabs'
        end

        def tab_class_name
          'Tab'
        end

        def sort_key_attribute_name
          'sort_key'
        end
      end
    end
  end
end