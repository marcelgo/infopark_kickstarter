module Cms
  module Generators
    module Component
      class ErrorTrackingGenerator < ::Rails::Generators::Base
        source_root File.expand_path('../templates', __FILE__)

        SUPPORTED_PROVIDER = %w(honeybadger airbrake)

        class_option :skip_deployment_notification,
          type: :boolean,
          default: false,
          desc: 'Skip to notify the error tracking provider of new deployments.'

        class_option :provider,
          type: :string,
          default: SUPPORTED_PROVIDER.first,
          desc: "Select what error tracking provider to use. (#{SUPPORTED_PROVIDER.join(' | ')})"

        def validate_provider
          unless SUPPORTED_PROVIDER.include?(provider)
            puts 'Please choose a supported provider. See options for more details.'
            puts

            self.class.help(self)

            exit
          end
        end

        def run_generator_for_selected_provider
          Rails::Generators.invoke(
            "cms:component:error_tracking:#{provider}",
            ["--skip-deployment-notification=#{options[:skip_deployment_notification]}"],
            behavior: behavior
          )
        end

        private

        def provider
          options[:provider]
        end
      end
    end
  end
end
