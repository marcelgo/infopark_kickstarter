module Cms
  module Generators
    module Widget
      class VideoGenerator < ::Rails::Generators::Base
        include Migration
        include BasePaths

        class_option :cms_path,
          type: :string,
          default: nil,
          desc: 'CMS parent path where the example widget should be placed.',
          banner: 'LOCATION'

        source_root File.expand_path('../templates', __FILE__)

        def video_tools
          gem('video_info')

          Bundler.with_clean_env do
            run('bundle --quiet')
          end
        end

        def create_migration
          begin
            validate_attribute(sort_key_attribute_name)
            Rails::Generators.invoke('cms:attribute', [sort_key_attribute_name, '--type=string', '--title=Sort Key'])
          rescue DuplicateResourceError
          end

          begin
            validate_attribute(video_file_attribute_name)
            Rails::Generators.invoke('cms:attribute', [video_file_attribute_name, '--type=linklist', '--title=Video: File', '--max-size=1'])

            remove_file 'app/concerns/cms/attributes/video_file.rb'
          rescue DuplicateResourceError
          end

          begin
            validate_attribute(video_link_attribute_name)
            Rails::Generators.invoke('cms:attribute', [video_link_attribute_name, '--type=linklist', '--title=Video: Url', '--max-size=1'])

            remove_file 'app/concerns/cms/attributes/video_link.rb'
          rescue DuplicateResourceError
          end

          begin
            validate_attribute(video_width_attribute_name)
            Rails::Generators.invoke('cms:attribute', [video_width_attribute_name, '--type=string', '--title=Width (optional)'])

            remove_file 'app/concerns/cms/attributes/video_width.rb'
          rescue DuplicateResourceError
          end

          begin
            validate_attribute(video_height_attribute_name)
            Rails::Generators.invoke('cms:attribute', [video_height_attribute_name, '--type=string', '--title=Height (optional)'])

            remove_file 'app/concerns/cms/attributes/video_height.rb'
          rescue DuplicateResourceError
          end

          begin
            validate_attribute(video_autoplay_attribute_name)
            Rails::Generators.invoke('cms:attribute', [video_autoplay_attribute_name, '--type=enum', '--title=Autoplay this video?', '--values=Yes', 'No'])

            remove_file 'app/concerns/cms/attributes/video_autoplay.rb'
          rescue DuplicateResourceError
          end

          begin
            validate_obj_class(obj_class_name)
            Rails::Generators.invoke('cms:model', [obj_class_name, '--title=Box: Video', "--attributes=#{video_file_attribute_name}", video_link_attribute_name, video_width_attribute_name, video_height_attribute_name, video_autoplay_attribute_name, sort_key_attribute_name])

            remove_file 'app/models/box_video.rb'
          rescue DuplicateResourceError
          end

          if behavior == :invoke
            log(:migration, 'Make sure to run "rake cms:migrate" to apply CMS changes')
          end
        end

        def copy_app_directory
          directory('app')
        end

        def add_example
          if example?
            migration_template('example_migration.rb', 'cms/migrate/create_video_widget_example.rb')
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
          'BoxVideo'
        end

        def sort_key_attribute_name
          'sort_key'
        end

        def video_file_attribute_name
          'video_file'
        end

        def video_link_attribute_name
          'video_link'
        end

        def video_width_attribute_name
          'video_width'
        end

        def video_height_attribute_name
          'video_height'
        end

        def video_autoplay_attribute_name
          'video_autoplay'
        end
      end
    end
  end
end