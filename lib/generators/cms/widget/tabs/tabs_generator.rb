module Cms
  module Generators
    module Widget
      class TabsGenerator < ::Rails::Generators::Base
        include Migration
        include BasePaths

        class_option :cms_path,
          type: :string,
          default: nil,
          desc: 'CMS parent path where the example widget should be placed.',
          banner: 'LOCATION'

        source_root File.expand_path('../templates', __FILE__)

        def update_application_js
          file = 'app/assets/javascripts/application.js'
          insert_point = "//= require infopark_rails_connector"

          data = []

          data << ''
          data << '$(document).ready(function() {'
          data << '});'

          data = data.join("\n")

          insert_into_file(file, data, after: insert_point)
        end

        def update_application_css
          file = 'app/assets/stylesheets/application.css'
          insert_point = '*= require infopark_rails_connector'

          data = []
          data << ''

          data = data.join("\n")

          insert_into_file(file, data, after: insert_point)
        end

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
            turn_model_into_box(obj_class_name)

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
            turn_model_into_box(tab_class_name)
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