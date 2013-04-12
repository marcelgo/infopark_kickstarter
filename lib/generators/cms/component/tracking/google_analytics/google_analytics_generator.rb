module Cms
  module Generators
    module Component
      module Tracking
        class GoogleAnalyticsGenerator < ::Rails::Generators::Base
          include Migration
          include BasePaths

          source_root File.expand_path('../templates', __FILE__)

          class_option :anonymize,
            type: :string,
            default: 'No',
            desc: 'Default anonymize ip setting. (Yes | No)',
            banner: 'VALUE'

          class_option :tracking_id,
            type: :string,
            default: '',
            desc: 'Default tracking id setting.',
            banner: 'ID'

          class_option :homepage_path,
            type: :string,
            default: nil,
            desc: 'Path to a CMS homepage, for which to create the google analytics configuration.'

          def insert_google_analytics
            file = 'app/views/layouts/application.html.haml'
            insert_point = "= javascript_include_tag('application')"

            data = []

            data << "\n"
            data << '    = render_cell(:google_analytics, :show, @obj.homepage)'

            data = data.join("\n")

            insert_into_file(file, data, after: insert_point)
          end

          def create_migration
            begin
              Model::ApiGenerator.new(behavior: behavior) do |model|
                model.name = class_name
                model.title = 'Google Analytics'
                model.attributes = [
                  {
                    name: tracking_id_attribute_name,
                    type: :string,
                    title: 'Tracking ID',
                    default: tracking_id_default,
                  },
                  {
                    name: anonymize_ip_attribute_name,
                    type: :boolean,
                    title: 'Anonymize IP?',
                    default: anonymize_ip_default,
                  },
                ]
              end
            rescue Cms::Generators::DuplicateResourceError
            end

            migration_template('migration.rb', 'cms/migrate/integrate_google_analytics.rb')
          end

          def copy_app_directory
            directory('app', force: true)
            directory('spec', force: true)
          end

          def notice
            if behavior == :invoke
              log(:migration, 'Make sure to run "rake cms:migrate" to apply CMS changes and set a Tracking ID.')
            end
          end

          private

          alias_method :original_homepage_path, :homepage_path
          def homepage_path
            options[:homepage_path] || original_homepage_path
          end

          def class_name
            'GoogleAnalytics'
          end

          def tracking_id_attribute_name
            'google_analytics_tracking_id'
          end

          def anonymize_ip_attribute_name
            'google_analytics_anonymize_ip'
          end

          def homepage_configuration_attribute_name
            'google_analytics'
          end

          def anonymize_ip_default
            options[:anonymize_ip_default]
          end

          def tracking_id_default
            options[:tracking_id_default]
          end
        end
      end
    end
  end
end