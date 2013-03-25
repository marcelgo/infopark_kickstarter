module Cms
  module Generators
    module Component
      class ErrorTrackingGenerator < ::Rails::Generators::Base
        source_root File.expand_path('../templates', __FILE__)

        SUPPORTED_PROVIDER = %w(airbrake honeybadger)

        class_option :skip_deployment_notification,
          :type => :boolean,
          :default => false,
          :desc => 'Skip to notify the error tracking provider of new deployments.'

        class_option :provider,
          :type => :string,
          :default => 'honeybadger',
          :desc => "Select what error tracking provider to use. (#{SUPPORTED_PROVIDER.join(' | ')})"

        def validate_provider
          unless SUPPORTED_PROVIDER.include?(options[:provider])
            puts "Please choose a supported provider. See options for more details."
            puts

            self.class.help(self)

            exit
          end
        end

        def run_generator_for_selectd_provider
          Rails::Generators.invoke(
            "cms:component:error_tracking:#{options[:provider]}",
            ["--skip-deployment-notification=#{options[:skip_deployment_notification]}"],
            behavior: behavior
          )
        end
      end
    end
  end
end