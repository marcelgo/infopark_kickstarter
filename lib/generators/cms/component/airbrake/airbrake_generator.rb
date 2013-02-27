module Cms
  module Generators
    module Component
      class AirbrakeGenerator < ::Rails::Generators::Base
        source_root File.expand_path('../templates', __FILE__)

        def include_gemfile
          gem('airbrake')

          Bundler.with_clean_env do
            run('bundle --quiet')
          end
        end

        def create_initializer_file
          template('airbrake.rb', File.join('config/initializers', 'airbrake.rb'))
        end

        def update_local_custom_cloud_file
          append_file('config/custom_cloud.yml') do
            File.read(find_in_source_paths('custom_cloud.yml'))
          end
        end

        def display_notice
          notice = if behavior == :invoke
            'Please run "rake cms:cloud_config:edit" to add
              "airbrake": { "api_key": "<your api key>" } to the platform
              configuration.'
          else
            'Please run "rake cms:cloud_config:edit" to remove
              "airbrake": { "api_key": "<your api key>" } from the platform
              configuration.'
          end

          log(:config, notice)
        end
      end
    end
  end
end