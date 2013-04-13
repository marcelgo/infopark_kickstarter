module Cms
  module Generators
    module Widget
      class VideoGenerator < ::Rails::Generators::Base
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
          data << "  $('.projekktor').each(function(event) {"
          data << "    projekktor('#' + $(this).attr('id'), {"
          data << "      playerFlashMP4: '/assets/jarisplayer.swf',"
          data << "      playerFlashMP3: '/assets/jarisplayer.swf',"
          data << "      autoplay: $(this).data('autoplay')"
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
            Model::ApiGenerator.new(behavior: behavior) do |model|
              model.name = obj_class_name
              model.title = 'Widget: Video'
              model.attributes = [
                {
                  name: sort_key_attribute_name,
                  type: :string,
                  title: 'Sort key',
                },
                {
                  name: video_link_attribute_name,
                  type: :linklist,
                  title: 'Video',
                  max_size: 1,
                },
                {
                  name: video_preview_image_attribute_name,
                  type: :linklist,
                  title: 'Banner image',
                  max_size: 1,
                },
                {
                  name: video_width_attribute_name,
                  type: :integer,
                  title: 'Width',
                  default: 660,
                },
                {
                  name: video_height_attribute_name,
                  type: :string,
                  title: 'Height',
                },
                {
                  name: video_autoplay_attribute_name,
                  type: :boolean,
                  title: 'Autoplay this video?',
                  default: 'No',
                },
              ]
            end
          rescue Cms::Generators::DuplicateResourceError
          end
        end

        def copy_app_directory
          directory('app', force: true)

          template('thumbnail.html.haml', 'app/widgets/video_widget/thumbnail.html.haml')
        end

        def notice
          if behavior == :invoke
            log(:migration, 'Make sure to run "rake cms:migrate" to apply CMS changes')
          end
        end

        private

        def obj_class_name
          'VideoWidget'
        end

        def sort_key_attribute_name
          'sort_key'
        end

        def video_link_attribute_name
          'video_link'
        end

        def video_preview_image_attribute_name
          'video_preview_image'
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