module Cms
  module Generators
    module Component
      module Monitoring
        class NewrelicGenerator < ::Rails::Generators::NamedBase
          Rails::Generators.hide_namespace(self.namespace)

          source_root File.expand_path('../templates', __FILE__)

          def include_gemfile
            gem('newrelic_rpm')

            Bundler.with_clean_env do
              run('bundle --quiet')
            end
          end

          def create_configuration_files
            template('newrelic.yml.erb', 'deploy/templates/newrelic.yml.erb')
            template('newrelic_developer.yml', 'config/newrelic.yml')
          end

          def append_after_restart_file
            destination = 'deploy/after_restart.rb'

            unless File.exist?(destination)
              create_file(destination)
            end

            append_template('after_restart.rb', destination)
          end

          def append_before_symlink_file
            destination = 'deploy/before_symlink.rb'

            unless File.exist?(destination)
              create_file(destination)
            end

            append_file(destination) do
              File.read(find_in_source_paths('before_symlink.rb'))
            end
          end

          def update_local_custom_cloud_file
            append_file('config/custom_cloud.yml') do
              File.read(find_in_source_paths('custom_cloud.yml'))
            end
          end

          def display_notice
            notice = if behavior == :invoke
              'Please run "rake cms:cloud_config:edit" to add
                "newrelic": { "api_key": "<your api key>", "deploy_key": "<your deploy api key>" }
                to the platform configuration.'
            else
              'Please run "rake cms:cloud_config:edit" to remove
                "newrelic": { "api_key": "<your api key>", "deploy_key": "<your deploy api key>" } from the platform
                configuration.'
            end

            log(:config, notice)
          end

          private

          def append_template(source, destination)
            source = find_in_source_paths(source)
            context = instance_eval('binding')
            content = ERB.new(::File.binread(source)).result(context)

            append_file(destination) do
              content
            end
          end
        end
      end
    end
  end
end