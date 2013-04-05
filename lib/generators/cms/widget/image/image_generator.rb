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
            validate_attribute(sort_key_attribute_name)
            Rails::Generators.invoke('cms:attribute', [sort_key_attribute_name, '--type=string', '--title=Sort Key'])
          rescue DuplicateResourceError
          end

          begin
            validate_attribute(caption_attribute_name)
            Rails::Generators.invoke('cms:attribute', [caption_attribute_name, '--type=string', '--title=Caption'])
          rescue DuplicateResourceError
          end

          begin
            validate_attribute(link_to_attribute_name)
            Rails::Generators.invoke('cms:attribute', [link_to_attribute_name, '--type=linklist', '--title=Link'])
          rescue DuplicateResourceError
          end

          begin
            validate_attribute(source_attribute_name)
            Rails::Generators.invoke('cms:attribute', [source_attribute_name, '--type=linklist', '--title=Source'])
          rescue DuplicateResourceError
          end

          begin
            validate_obj_class(obj_class_name)
            Rails::Generators.invoke('cms:model', [obj_class_name, '--title=Widget: Image', "--attributes=#{source_attribute_name}", caption_attribute_name, link_to_attribute_name, sort_key_attribute_name])

            turn_model_into_widget(obj_class_name)
          rescue DuplicateResourceError
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

        def human_name
          'Image Widget'
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