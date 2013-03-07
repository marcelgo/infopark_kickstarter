require 'yaml'

module IceKickstarter
  module Rake
    class ConfigurationHelper
      attr_reader :file
      attr_reader :configuration
      attr_reader :target

      def initialize(file, type, target)
        @file = file
        @configuration = send("#{type}_configuration")
        @target = target
      end

      def write
        content = configuration.to_yaml

        File.open(target, 'w') do |file|
          file.write(content)
        end
      end

      private

      def cms_configuration
        {
          'cms_api' => {
            'url' => 'https://admin.saas.infopark.net/cms',
            'login' => 'root',
            'api_key' => choose_correct_value(local_configuration['integration_test_cms_api_key']),
            'http_host' => choose_correct_value(local_configuration['integration_test_tenant_name']),
          },
          'content_service' => {
            'url' => 'https://contents.infopark.net',
            'login' => choose_correct_value(local_configuration['integration_test_tenant_name']),
            'api_key' => choose_correct_value(local_configuration['integration_test_content_read_api_key']),
          }
        }
      end

      def crm_configuration
        {
          'crm' => {
            'url' => 'https://admin.saas.infopark.net/crm',
            'login' => 'root',
            'api_key' => choose_correct_value(local_configuration['integration_test_crm_api_key']),
            'http_host' => choose_correct_value(local_configuration['integration_test_tenant_name']),
          }
        }
      end

      def deploy_configuration
        {
          'url' => choose_correct_value(local_configuration['integration_test_tenant_url']),
          'api_key' => choose_correct_value(local_configuration['integration_test_tenant_api_key']),
        }
      end

      def local_configuration
        content = File.read(file)

        ::YAML.load(content)
      end

      def choose_correct_value(value)
        if value.instance_of?(Hash)
          value[server_name]
        else
          value
        end
      end

      def server_name
        %x'hostname'.strip
      end
    end
  end
end