module Cms
  module Generators
    module Component
      class ContactPageGenerator < ::Rails::Generators::Base
        include Migration
        include Actions

        class_option :cms_path,
          type: :string,
          default: nil,
          desc: 'CMS parent path where the example contact page should be placed under.'

        source_root File.expand_path('../templates', __FILE__)

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

            turn_model_into_page(class_name)
          rescue Cms::Generators::DuplicateResourceError
          end
        end

        def create_example
          if example?
            migration_template('example_migration.rb', 'cms/migrate/create_contact_page_example.rb')
          end
        end

        def copy_app_directory
          directory('app', force: true)
          directory('config', force: true)
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

        def notice
          if behavior == :invoke
            log(:migration, 'Make sure to run "rake cms:migrate" to apply CMS changes and "bundle" to install new gem.')
          end
        end

        private

        def example?
          cms_path.present?
        end

        def cms_path
          options[:cms_path]
        end

        def class_name
          'ContactPage'
        end

        def crm_activity_type_attribute_name
          'crm_activity_type'
        end

        def show_in_navigation_attribute_name
          'show_in_navigation'
        end

        def sort_key_attribute_name
          'sort_key'
        end

        def activity_type
          'contact-form'
        end
      end
    end
  end
end