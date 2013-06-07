module Cms
  module Generators
    module Component
      class LoginPageGenerator < ::Rails::Generators::Base
        include Migration
        include BasePaths
        include Actions

        source_root File.expand_path('../templates', __FILE__)

        def create_migration
          begin
            Model::ApiGenerator.new(behavior: behavior) do |model|
              model.name = obj_class_name
              model.title = 'Page: Login'
              model.thumbnail = false
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

            turn_model_into_page(obj_class_name)
          rescue Cms::Generators::DuplicateResourceError
          end
        end

        def copy_app_directory
          directory('app', force: true)
          directory('config', force: true)
        end

        def update_homepage
          migration_template('migration.rb', 'cms/migrate/update_homepage_obj.rb')
        end

        def update_homepage_model
            file = 'app/models/homepage.rb'

            data = "\n  cms_attribute :login_page_link, type: :linklist"
            insert_point = "class Homepage < Obj"

            insert_into_file(file, data, after: insert_point)

            data = [
              "\n",
              '  def login_page',
              '    login_page_link.destination_objects.first',
              '  end',
            ].join("\n")
            insert_point = "include Page"

            insert_into_file(file, data, after: insert_point)

        end

        def update_footer_cell
          append_file 'app/cells/footer/show.html.haml' do
            [
              "\n",
              '          |',
              '          = render_cell(:login, :show, @page)',
            ].join("\n")
          end

        end

        def notice
          if behavior == :invoke
            log(:migration, 'Make sure to run "rake cms:migrate" to apply CMS changes.')
          end
        end

        private

        def obj_class_name
          'LoginPage'
        end
      end
    end
  end
end