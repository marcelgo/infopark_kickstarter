module Cms
  module Generators
    module Component
      class MonitoringGenerator < ::Rails::Generators::NamedBase
        source_root File.expand_path('../templates', __FILE__)

        SUPPORTED_PROVIDER = %w(newrelic)

        class_option :provider,
          type: :string,
          default: SUPPORTED_PROVIDER.first,
          desc: "Select what monitoring provider to use. (#{SUPPORTED_PROVIDER.join(' | ')})"

        def validate_provider
          unless SUPPORTED_PROVIDER.include?(options[:provider])
            puts 'Please choose a supported provider. See options for more details.'
            puts

            self.class.help(self)

            exit
          end
        end

        def run_generator_for_selected_provider
          Rails::Generators.invoke(
            "cms:component:monitoring:#{options[:provider]}",
            [name],
            behavior: behavior
          )
        end
      end
    end
  end
end
