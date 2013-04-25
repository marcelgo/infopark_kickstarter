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
              model.migration_path = "#{widget_path}/migrate"
              model.model_path = model_path
              model.attributes = [
                {
                  name: 'headline',
                  type: :string,
                  title: 'Headline',
                },
                {
                  name: 'content',
                  type: :html,
                  title: 'Content',
                },
                {
                  name: 'source',
                  type: :linklist,
                  title: 'Source',
                  max_size: 1,
                },
                {
                  name: 'poster',
                  type: :linklist,
                  title: 'Poster',
                  max_size: 1,
                },
                {
                  name: 'width',
                  type: :integer,
                  title: 'Width',
                  default: 660,
                },
                {
                  name: 'height',
                  type: :string,
                  title: 'Height',
                  default: 430,
                },
                {
                  name: 'autoplay',
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

          template('thumbnail.html.haml', "#{widget_path}/views/thumbnail.html.haml")
        end

        def notice
          if behavior == :invoke
            log(:migration, 'Make sure to run "rake cms:migrate" to apply CMS changes')
          end
        end

        private

        def widget_path
          'app/widgets/video_widget'
        end

        def model_path
          'app/models'
        end

        def obj_class_name
          'VideoWidget'
        end
      end
    end
  end
end