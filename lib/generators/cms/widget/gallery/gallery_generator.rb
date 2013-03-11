module Cms
  module Generators
    module Widget
      class GalleryGenerator < ::Rails::Generators::Base
        include Migration
        include BasePaths

        class_option :cms_path,
          type: :string,
          default: nil,
          desc: 'CMS parent path where the example widget should be placed.',
          banner: 'LOCATION'

        source_root File.expand_path('../templates', __FILE__)

        def create_migration
          begin
            validate_attribute(sort_key_attribute_name)
            Rails::Generators.invoke('cms:attribute', [sort_key_attribute_name, '--type=string', '--title=Sort Key'])
          rescue DuplicateResourceError
          end

          begin
            validate_attribute(gallery_images_attribute_name)
            Rails::Generators.invoke('cms:attribute', [gallery_images_attribute_name, '--type=linklist', '--title=Gallery: Images'])
          rescue DuplicateResourceError
          end

          begin
            validate_attribute(gallery_delay_attribute_name)
            Rails::Generators.invoke('cms:attribute', [gallery_delay_attribute_name, '--type=string', '--title=Gallery: delay (optional)'])
          rescue DuplicateResourceError
          end

          begin
            validate_attribute(gallery_autoplay_attribute_name)
            Rails::Generators.invoke('cms:attribute', [gallery_autoplay_attribute_name, '--type=enum', '--title=Autoplay this gallery?', '--values=Yes', 'No'])
          rescue DuplicateResourceError
          end

          begin
            validate_obj_class(obj_class_name)
            Rails::Generators.invoke('cms:model', [obj_class_name, '--title=Box: Gallery', "--attributes=#{gallery_images_attribute_name}", gallery_delay_attribute_name, gallery_autoplay_attribute_name, sort_key_attribute_name])
          rescue DuplicateResourceError
          end

          if behavior == :invoke
            log(:migration, 'Make sure to run "rake cms:migrate" to apply CMS changes')
          end
        end

        def copy_app_directory
          directory('app', force: true)
        end

        def add_example
          if example?
            migration_template('example_migration.rb', 'cms/migrate/create_gallery_widget_example.rb')
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
          'BoxGallery'
        end

        def sort_key_attribute_name
          'sort_key'
        end

        def gallery_images_attribute_name
          'gallery_images'
        end

        def gallery_delay_attribute_name
          'gallery_delay'
        end

        def gallery_autoplay_attribute_name
          'gallery_autoplay'
        end
      end
    end
  end
end