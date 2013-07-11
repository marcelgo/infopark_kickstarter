module Cms
  module Generators
    module Widget
      class MapsGenerator < ::Rails::Generators::Base
        include Example

        source_root File.expand_path('../templates', __FILE__)

        SUPPORTED_PROVIDER = %w(google_maps)

        class_option :provider,
          :type => :string,
          :default => 'google_maps',
          :desc => "Select what maps provider to use. (#{SUPPORTED_PROVIDER.join(' | ')})"

        def validate_provider
          unless SUPPORTED_PROVIDER.include?(options[:provider])
            puts 'Please choose a supported provider. See options for more details.'
            puts

            self.class.help(self)

            exit
          end
        end

        def run_generator_for_selected_provider
          invoke_options = []

          invoke_options << '--example' if example?
          invoke_options << "--obj_path=#{example_obj_path}" if example_obj_path?
          invoke_options << "--attribute=#{example_obj_widget_attribute}" if example_obj_widget_attribute?

          Rails::Generators.invoke(
            "cms:widget:maps:#{options[:provider]}",
            invoke_options
          )
        end
      end
    end
  end
end