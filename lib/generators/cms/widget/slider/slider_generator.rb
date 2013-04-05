module Cms
  module Generators
    module Widget
      class SliderGenerator < ::Rails::Generators::Base
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
            validate_attribute(slider_images_attribute_name)
            Rails::Generators.invoke('cms:attribute', [slider_images_attribute_name, '--type=linklist', '--title=Images'])
          rescue DuplicateResourceError
          end

          begin
            validate_obj_class(obj_class_name)
            Rails::Generators.invoke('cms:model', [obj_class_name, '--title=Widget: Slider', "--attributes=#{slider_images_attribute_name}", sort_key_attribute_name])
            turn_model_into_widget(obj_class_name)
          rescue DuplicateResourceError
          end
        end

        def copy_app_directory
          directory('app', force: true)

          template('thumbnail.html.haml', 'app/widgets/slider_widget/thumbnail.html.haml')
        end

        def add_example
          if example?
            migration_template('example_migration.rb', 'cms/migrate/create_slider_widget_example.rb')
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
          'Slider Widget'
        end

        def obj_class_name
          'SliderWidget'
        end

        def sort_key_attribute_name
          'sort_key'
        end

        def slider_images_attribute_name
          'slider_images'
        end
      end
    end
  end
end