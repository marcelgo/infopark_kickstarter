module Cms
  module Generators
    module Component
      module ErrorTracking
        class AirbrakeGenerator < ::Rails::Generators::Base
          Rails::Generators.hide_namespace(self.namespace)

          source_root File.expand_path('../templates', __FILE__)

          class_option :skip_deployment_notification,
            type: :boolean,
            default: false,
            desc: 'Skip to notify airbrake on new deployments.'

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

          def add_deployment_notification
            unless options[:skip_deployment_notification]
              destination = 'deploy/after_restart.rb'

              unless File.exist?(destination)
                create_file(destination)
              end

              append_file(destination) do
                File.read(find_in_source_paths('after_restart.rb'))
              end
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
end
