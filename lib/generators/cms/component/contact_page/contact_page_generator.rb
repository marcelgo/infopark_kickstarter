module Cms
  module Generators
    module Component
      class ContactPageGenerator < ::Rails::Generators::Base
        include Migration
        include BasePaths
        include Actions

        class_option :homepage_path,
          type: :string,
          default: nil,
          desc: 'Path to a CMS homepage, for which to create the contact form.'

        source_root File.expand_path('../templates', __FILE__)

        def add_email_validation
          gem('valid_email', '0.0.4')

          Bundler.with_clean_env do
            run('bundle --quiet')
          end
        end

        def extend_homepage
          file = 'app/models/homepage.rb'
          insert_point = "class Homepage < Obj\n"

          data = []

          data << '  include Cms::Attributes::ContactPageLink'
          data << ''

          data = data.join("\n")

          insert_into_file(file, data, after: insert_point)
        end

        def extend_cell
          file = 'app/cells/meta_navigation_cell.rb'
          insert_point = "@current_user = current_user\n"

          data = []

          data << ''
          data << '    @contact_page = page.homepage.contact_page'
          data << ''

          data = data.join("\n")

          insert_into_file(file, data, after: insert_point)
        end

        def extend_view
          file = 'app/cells/meta_navigation/show.html.haml'
          insert_point = "      = t('.meta')\n"

          data = []

          data << '    %li'
          data << '      = link_to(cms_path(@contact_page)) do'
          data << '        = display_title(@contact_page)'
          data << ''

          data = data.join("\n")

          insert_into_file(file, data, after: insert_point)
        end

        def create_migration
          begin
            Model::ApiGenerator.new(behavior: behavior) do |model|
              model.name = class_name
              model.title = 'Page: Contact'
              model.attributes = [
                {
                  name: crm_activity_type_attribute_name,
                  type: :string,
                  title: 'CRM Activity Type',
                },
                {
                  name: redirect_after_submit_attribute_name,
                  type: :linklist,
                  title: 'Redirect After Submit Page',
                  max_size: 1,
                },
                {
                  name: show_in_navigation_attribute_name,
                  type: :boolean,
                  title: 'Show in navigation',
                },
              ]
            end

            turn_model_into_page(class_name)
          rescue Cms::Generators::DuplicateResourceError
          end

          migration_template('example_migration.rb', 'cms/migrate/create_contact_page_example.rb')

          if behavior == :invoke
            log(:migration, 'Make sure to run "rake cms:migrate" to apply CMS changes and "bundle" to install new gem.')
          end
        end

        def copy_app_directory
          directory('app', force: true)
          directory('config', force: true)
          directory('spec', force: true)
        end

        def remove_custom_type
          if behavior == :revoke
            begin
              custom_type = Infopark::Crm::CustomType.find(activity_type)

              if yes?("Do you also want to delete the WebCRM activity type '#{activity_type}'?")
                custom_type.destroy

                say_status(:remove, "custom activity type #{activity_type}", :red)
              end
            rescue ActiveResource::ResourceNotFound
              say_status(:remove, "custom activity type #{activity_type} does not exist", :red)
            end
          end
        end

        private

        alias_method :original_homepage_path, :homepage_path
        def homepage_path
          options[:homepage_path] || original_homepage_path
        end

        def class_name
          'ContactPage'
        end

        def crm_activity_type_attribute_name
          'crm_activity_type'
        end

        def redirect_after_submit_attribute_name
          'redirect_after_submit_link'
        end

        def contact_page_attribute_name
          'contact_page_link'
        end

        def show_in_navigation_attribute_name
          'show_in_navigation'
        end

        def activity_type
          'contact-form'
        end
      end
    end
  end
end