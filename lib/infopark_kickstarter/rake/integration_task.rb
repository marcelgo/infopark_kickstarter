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
            create_configuration_files
            create_application
            call_generators
            run_tests
          end
        end
      end

      private

      def prepare_directory
        rm_rf(app_path)
        mkdir_p(config_path)
      end

      def create_configuration_files
        ConfigurationHelper.new(local_configuration_file, :cms, "#{config_path}/rails_connector.yml").write
        ConfigurationHelper.new(local_configuration_file, :crm, "#{config_path}/custom_cloud.yml").write
        ConfigurationHelper.new(local_configuration_file, :deploy, "#{config_path}/deploy.yml").write
      end

      def create_application
        Bundler.with_clean_env do
          sh("rails new #{app_path} --skip-test-unit --skip-active-record --skip-bundle --template template.rb")

          cd(app_path) do
            sh('bundle --quiet')

            migrate!
          end
        end
      end

      def call_generators
        Bundler.with_clean_env do
          cd(app_path) do
            generators = [
              'cms:component:error_tracking --provider=airbrake',
              'cms:component:error_tracking --provider=honeybadger',
              'cms:component:monitoring "Test Website" --provider=newrelic',
              'cms:component:google_analytics',
              'cms:component:contact_page',
              'cms:component:language_switch',
              'cms:component:profile_page',
              'cms:component:blog --cms_path=/website/en',
              'cms:widget:google_maps --cms_path=/website/en/_boxes',
              'cms:widget:video --cms_path=/website/en/_boxes',
              'cms:widget:person --cms_path=/website/en/_boxes',
              'cms:widget:slider --cms_path=/website/en/_boxes',
            ]

            generators.each do |generator|
              sh("bundle exec rails generate #{generator}")
            end

            migrate!
          end
        end
      end

      def migrate!
        sh('bundle exec rake cms:migrate')
      end

      def run_tests
        Bundler.with_clean_env do
          cd(app_path) do
            sh('bundle exec rake spec')
          end
        end
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