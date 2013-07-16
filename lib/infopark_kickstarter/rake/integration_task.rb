require 'rake'
require 'rake/tasklib'

require 'infopark_kickstarter/rake/configuration_helper'

module InfoparkKickstarter
  module Rake
    class IntegrationTask < ::Rake::TaskLib
      def initialize
        namespace :test do
          desc 'Run Kickstarter Integration Tests'

          task :integration do
            prepare_directory
            create_application
            create_configuration_files

            cd(app_path) do
              Bundler.with_clean_env do
                reset_cms
                kickstart
                call_generators
                run_tests
              end
            end
          end
        end
      end

      private

      def prepare_directory
        rm_rf(app_path)
        mkdir_p(config_path)
      end

      def create_application
        sh("rails new #{app_path} --skip-test-unit --skip-active-record --template template.rb")
      end

      def create_configuration_files
        ConfigurationHelper.new(local_configuration_file, :cms, "#{config_path}/rails_connector.yml").write
        ConfigurationHelper.new(local_configuration_file, :crm, "#{config_path}/custom_cloud.yml").write
        ConfigurationHelper.new(local_configuration_file, :deploy, "#{config_path}/deploy.yml").write
      end

      def reset_cms
        sh('bundle exec rake cms:reset[true]')
      end

      def bundle
        sh('bundle --quiet')
      end

      def kickstart
        sh('bundle exec rails generate cms:kickstart --examples')
      end

      def call_generators
        generators = [
          'cms:component:testing',
          'cms:component:redirect',
          'cms:component:error_tracking --provider=airbrake',
          'cms:component:error_tracking --provider=honeybadger',
          'cms:component:monitoring "Test Website" --provider=newrelic',
          'cms:component:tracking --provider=google_analytics',
          'cms:component:language_switch --example',
          'cms:component:form_builder --cms_path=/website/en',
          'cms:component:social_sharing --example',
          'cms:component:breadcrumbs',
          'cms:widget:video --example',
          'cms:widget:person --example',
          'cms:widget:slider --example',
          'cms:widget:login --example',
          'cms:widget:slideshare --example',
        ]

        generators.each do |generator|
          sh("bundle exec rails generate #{generator}")
        end

        sh('bundle exec rake cms:migrate')
      end

      def run_tests
        sh('bundle exec rake spec')
      end

      def app_path
        'tmp/test_app'
      end

      def config_path
        "#{app_path}/config"
      end

      def local_configuration_file
        file_locations = [
          'config/local.yml',
          "#{ENV["HOME"]}/.config/infopark/kickstarter.yml",
        ]

        file = file_locations.detect do |path|
          Pathname(path).exist?
        end

        unless file
          raise 'Local configuration file not found. Provide either "config/local.yml" or "~/.config/infopark/kickstarter.yml". See "config/local.yml.template" for an example.'
        end

        file
      end
    end
  end
end