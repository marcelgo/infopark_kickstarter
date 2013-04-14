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
          data << '//= require projekktor.config'

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
                  title: 'Source',
                  max_size: 1,
                },
                {
                  name: video_poster_attribute_name,
                  type: :linklist,
                  title: 'Poster',
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
                  default: 430,
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
          'source'
        end

        def video_poster_attribute_name
          'poster'
        end

        def video_width_attribute_name
          'width'
        end

        def video_height_attribute_name
          'height'
        end

        def video_autoplay_attribute_name
          'autoplay'
        end
      end
    end
  end
end