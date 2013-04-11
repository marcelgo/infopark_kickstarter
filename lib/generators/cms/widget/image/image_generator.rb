module Cms
  module Generators
    module Widget
      class ImageGenerator < ::Rails::Generators::Base
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
              model.title = 'Widget: Image'
              model.attributes = [
                {
                  name: sort_key_attribute_name,
                  type: :string,
                  title: 'Sort key',
                },
                {
                  name: caption_attribute_name,
                  type: :string,
                  title: 'Caption',
                },
                {
                  name: link_to_attribute_name,
                  type: :linklist,
                  title: 'Link',
                  max_size: 1,
                },
                {
                  name: source_attribute_name,
                  type: :linklist,
                  title: 'Source',
                  max_size: 1,
                },
              ]
            end

            turn_model_into_widget(obj_class_name)
          rescue Cms::Generators::DuplicateResourceError
          end
        end

        def create_widget
          directory('app')

          template('thumbnail.html.haml', 'app/widgets/image_widget/thumbnail.html.haml')
        end

        def add_example
          if example?
            migration_template('example_migration.rb', 'cms/migrate/create_image_widget_example.rb')
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
          'ImageWidget'
        end

        def sort_key_attribute_name
          'sort_key'
        end

        def source_attribute_name
          'source'
        end

        def link_to_attribute_name
          'link_to'
        end

        def caption_attribute_name
          'caption'
        end
      end
    end
  end
end