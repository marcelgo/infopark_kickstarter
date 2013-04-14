module Cms
  module Generators
    module Component
      class TrackingGenerator < ::Rails::Generators::Base
        source_root File.expand_path('../templates', __FILE__)

        SUPPORTED_PROVIDER = %w(google_analytics)

        class_option :provider,
          :type => :string,
          :default => 'google_analytics',
          :desc => "Select what tracking provider to use. (#{SUPPORTED_PROVIDER.join(' | ')})"

        class_option :anonymize,
          type: :string,
          default: 'No',
          desc: 'Default anonymize ip setting. (Yes | No)',
          banner: 'VALUE'

        class_option :tracking_id,
          type: :string,
          default: '',
          desc: 'Default tracking id setting.',
          banner: 'ID'

        class_option :homepage_path,
            type: :string,
            default: nil,
            desc: 'Path to a CMS homepage, for which to create the tracking configuration.'

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
            "cms:component:tracking:google_analytics", [
              "--anonymize=#{anonymize?}",
              "--tracking_id=#{tracking_id}",
              "--homepage_path=#{homepage_path}"
            ]
          )
        end

        private

        def anonymize?
          options[:anonymize]
        end

        def tracking_id
          options[:tracking_id]
        end

        def homepage_path
          options[:homepage_path]
        end
      end
    end
  end
end