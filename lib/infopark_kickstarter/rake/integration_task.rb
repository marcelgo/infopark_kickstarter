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
                bundle
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
        test_app_config = File.expand_path('../../../../tmp/test_app/config', __FILE__)

        ConfigurationHelper.new(test_app_config).copy_configurations
      end

      def bundle
        sh('bundle --quiet')
      end

      def reset_cms
        sh('bundle exec rake cms:reset[true]')
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
          'cms:widget:column --columns=2 --example',
          'cms:widget:column --columns=3 --example',
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

    end
  end
end
