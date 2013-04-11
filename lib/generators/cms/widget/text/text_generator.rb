module Cms
  module Generators
    module Widget
      class TextGenerator < ::Rails::Generators::Base
        include Migration
        include BasePaths
        include Actions

        class_option :example,
          type: :boolean,
          default: false,
          desc: 'Generate an example migration?'

        source_root File.expand_path('../templates', __FILE__)

        def create_migration
          begin
            Model::ApiGenerator.new(behavior: behavior) do |model|
              model.name = obj_class_name
              model.title = 'Widget: Text'
              model.attributes = [
                {
                  name: sort_key_attribute_name,
                  type: :string,
                  title: 'Sort key',
                },
              ]
            end

            turn_model_into_widget(obj_class_name)
          rescue Cms::Generators::DuplicateResourceError
          end
        end

        def create_widget
          directory('app')

          template('thumbnail.html.haml', 'app/widgets/text_widget/thumbnail.html.haml')
        end

        def add_example
          if example?
            migration_template('example_migration.rb', 'cms/migrate/create_text_widget_example.rb')
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
          'TextWidget'
        end

        def sort_key_attribute_name
          'sort_key'
        end
      end
    end
  end
end