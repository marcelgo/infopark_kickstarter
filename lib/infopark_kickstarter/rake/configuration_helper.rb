
module InfoparkKickstarter
  module Rake
    ConfigurationHelper = Struct.new(:cp_target) do
      def copy_configurations
        ['rails_connector.yml', 'custom_cloud.yml', 'deploy.yml'].each do |file_name|
          file_path = File.join(config_path, file_name)

          if File.exist?(file_path)
            FileUtils.cp(file_path, cp_target)
          end
        end
      end

      private

      def config_path
        File.expand_path('../../../../config', __FILE__)
      end
    end
  end
end
