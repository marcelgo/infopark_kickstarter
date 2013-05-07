module InfoparkKickstarter
  module Rake
    module CredentialHelper
      def url
        config['url']
      end

      def api_key
        config['api_key']
      end

      def tenant_name
        rails_connector_config['cms_api']['url'].match(/\/\/(.*?)\./)[1]
      end

      def config
        YAML.load_file(Rails.root + 'config/deploy.yml')
      rescue Errno::ENOENT => error
        puts %{
          You are missing the "config/deploy.yml" file to connect to the Infopark console.
          Please consult Infopark DevCenter Getting Started section on how to configure your application.

          https://dev.infopark.net
        }

        exit
      end

      def rails_connector_config
        YAML.load_file(Rails.root + 'config/rails_connector.yml')
      rescue Errno::ENOENT => error
        puts %{
          You are missing the "config/rails_connector.yml" file to connect to the Infopark CMS.
          Please consult Infopark DevCenter Getting Started section on how to configure your application.

          https://dev.infopark.net
        }

        exit
      end
    end
  end
end