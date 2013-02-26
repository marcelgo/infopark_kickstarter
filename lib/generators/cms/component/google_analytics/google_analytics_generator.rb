module Cms
  module Generators
    module Component
      class GoogleAnalyticsGenerator < ::Rails::Generators::Base
        include Migration
        include BasePaths

        source_root File.expand_path('../templates', __FILE__)

        class_option :anonymize_ip_default,
          type: :string,
          default: 'No',
          desc: 'Default anonymize ip setting. (Yes | No)',
          banner: 'VALUE'

        class_option :tracking_id_default,
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
          validate_obj_class(class_name)

          begin
            validate_attribute(tracking_id_attribute_name)
            Rails::Generators.invoke('cms:attribute', [tracking_id_attribute_name, '--type=string', '--title=Tracking ID'])
          rescue DuplicateResourceError
          end

          begin
            validate_attribute(anonymize_ip_attribute_name)
            Rails::Generators.invoke('cms:attribute', [anonymize_ip_attribute_name, '--type=boolean', '--title=Anonymize IP?'])
          rescue DuplicateResourceError
          end

          begin
            validate_attribute(homepage_configuration_attribute_name)
            Rails::Generators.invoke('cms:attribute', [homepage_configuration_attribute_name, '--type=linklist', '--title=Google Analytics', '--max-size=1'])
          rescue DuplicateResourceError
          end

          begin
            validate_obj_class(class_name)
            Rails::Generators.invoke('cms:model', [class_name, '--title=Google Analytics', "--attributes=#{tracking_id_attribute_name}", anonymize_ip_attribute_name])
          rescue DuplicateResourceError
          end

          migration_template('migration.rb', 'cms/migrate/integrate_google_analytics.rb')

          if behavior == :invoke
            log(:migration, 'Make sure to run "rake cms:migrate" to apply CMS changes and set a Tracking ID.')
          end
        end

        def copy_app_directory
          directory('app', force: true)
          directory('spec', force: true)
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