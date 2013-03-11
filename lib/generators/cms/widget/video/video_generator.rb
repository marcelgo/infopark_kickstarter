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
          gem('projekktor-rails')

          Bundler.with_clean_env do
            run('bundle --quiet')
          end
        end

        def update_application_js
          file = 'app/assets/javascripts/application.js'
          insert_point = "//= require infopark_rails_connector"

          data = []

          data << ''
          data << '//= require projekktor'
          data << ''
          data << '$(document).ready(function() {'
          data << '  $(".projekktor").each(function(event) {'
          data << '    projekktor("#"+$(this).attr("id"), {'
          data << '      playerFlashMP4: "/assets/jarisplayer.swf",'
          data << '      playerFlashMP3: "/assets/jarisplayer.swf",'
          data << '      autoplay: $(this).data("autoplay")'
          data << '    });'
          data << '  });'
          data << '});'

          data = data.join("\n")

          insert_into_file(file, data, after: insert_point)
        end

        def update_application_css
          file = 'app/assets/stylesheets/application.css'
          insert_point = '*= require infopark_rails_connector'

          data = []
          data << ''
          data << ' *= require projekktor'

          data = data.join("\n")

          insert_into_file(file, data, after: insert_point)
        end

        def create_migration
          begin
            validate_attribute(sort_key_attribute_name)
            Rails::Generators.invoke('cms:attribute', [sort_key_attribute_name, '--type=string', '--title=Sort Key'])
          rescue DuplicateResourceError
          end

          begin
            validate_attribute(video_link_attribute_name)
            Rails::Generators.invoke('cms:attribute', [video_link_attribute_name, '--type=linklist', '--title=Video: Url', '--max-size=1'])
          rescue DuplicateResourceError
          end

          begin
            validate_attribute(video_width_attribute_name)
            Rails::Generators.invoke('cms:attribute', [video_width_attribute_name, '--type=string', '--title=Width (optional)'])
          rescue DuplicateResourceError
          end

          begin
            validate_attribute(video_height_attribute_name)
            Rails::Generators.invoke('cms:attribute', [video_height_attribute_name, '--type=string', '--title=Height (optional)'])
          rescue DuplicateResourceError
          end

          begin
            validate_attribute(video_autoplay_attribute_name)
            Rails::Generators.invoke('cms:attribute', [video_autoplay_attribute_name, '--type=enum', '--title=Autoplay this video?', '--values=Yes', 'No'])
          rescue DuplicateResourceError
          end

          begin
            validate_obj_class(obj_class_name)
            Rails::Generators.invoke('cms:model', [obj_class_name, '--title=Box: Video', "--attributes=#{video_link_attribute_name}", video_width_attribute_name, video_height_attribute_name, video_autoplay_attribute_name, sort_key_attribute_name])
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