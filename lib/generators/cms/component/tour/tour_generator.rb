module Cms
  module Generators
    module Component
      class TourGenerator < ::Rails::Generators::Base
        include Example
        include Migration
        include Actions
        include BasePaths

        source_root File.expand_path('../templates', __FILE__)

        def update_javascript_manifest
          insert_into_javascript_manifest('infopark_rails_connector', 'tour')
          insert_into_javascript_manifest('tour', 'tour.config')
        end

        def update_stylesheet_manifest
          insert_into_stylesheet_manifest('infopark_rails_connector', 'tour')
        end

        def create_migration
          begin
            Model::ApiGenerator.new(behavior: behavior) do |model|
              model.name = tour_obj_class_name
              model.title = 'Page: Tour'
              model.thumbnail = true
              model.page = true
              model.attributes = [
                {
                  name: 'headline',
                  type: :string,
                  title: 'Headline',
                },
              ]
            end
          rescue Cms::Generators::DuplicateResourceError
          end

          begin
            Model::ApiGenerator.new(behavior: behavior) do |model|
              model.name = tour_step_obj_class_name
              model.title = 'Page: Tour Step'
              model.thumbnail = false
              model.page = true
              model.attributes = [
                {
                  name: 'headline',
                  type: :string,
                  title: 'Headline',
                },
                {
                  name: 'content',
                  type: :widget,
                  title: 'Content',
                },
                {
                  name: 'show_in_navigation',
                  type: :boolean,
                  title: 'Show in Navigation',
                },
                {
                  name: 'sort_key',
                  type: :string,
                  title: 'Sort key',
                },
              ]
            end
          rescue Cms::Generators::DuplicateResourceError
          end
        end

        def copy_app_directory
          directory('app', force: true)
        end

        def create_example
          if example?
            migration_template('example_migration.rb', "#{migration_path}/create_tour_example.rb")
          end
        end

        def notice
          if behavior == :invoke
            log(:migration, 'Make sure to run "rake cms:migrate" to apply CMS changes')
          end
        end

        private

        def tour_obj_class_name
          'Tour'
        end

        def tour_step_obj_class_name
          'TourStep'
        end
      end
    end
  end
end