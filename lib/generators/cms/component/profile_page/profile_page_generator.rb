module Cms
  module Generators
    module Component
      class ProfilePageGenerator < ::Rails::Generators::Base
        include Migration
        include BasePaths

        class_option :cms_path,
          type: :string,
          default: nil,
          desc: 'CMS parent path where the example profile should be placed under.',
          banner: 'LOCATION'

        source_root File.expand_path('../templates', __FILE__)

        def create_migration
          begin
            Model::ApiGenerator.new(behavior: behavior) do |model|
              model.name = obj_class_name
              model.title = 'Page: Profile'
              model.page = true
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
                  name: show_in_navigation_attribute_name,
                  type: :boolean,
                  title: 'Show in navigation',
                },
                {
                  name: sort_key_attribute_name,
                  type: :string,
                  title: 'Sort key',
                },
              ]
            end
          rescue Cms::Generators::DuplicateResourceError
          end
        end

        def create_example
          if example?
            migration_template('example_migration.rb', 'cms/migrate/create_profile_page_example.rb')
          end
        end

        def copy_app_directory
          directory('app', force: true)
          directory('config', force: true)
        end

        def notice
          if behavior == :invoke
            log(:migration, 'Make sure to run "rake cms:migrate" to apply CMS changes.')
          end
        end

        private

        def example?
          cms_path.present?
        end

        def cms_path
          options[:cms_path]
        end

        def show_in_navigation_attribute_name
          'show_in_navigation'
        end

        def sort_key_attribute_name
          'sort_key'
        end

        def obj_class_name
          'ProfilePage'
        end
      end
    end
  end
end