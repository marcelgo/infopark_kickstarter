module Cms
  module Generators
    module Component
      class NewrelicGenerator < ::Rails::Generators::NamedBase
        source_root File.expand_path('../templates', __FILE__)

        def include_gemfile
          gem_group :production, :staging do
            gem 'newrelic_rpm'
          end

          Bundler.with_clean_env do
            run('bundle --quiet')
          end
        end

        def create_template_file
          template('newrelic.yml.erb', File.join('deploy/templates', 'newrelic.yml.erb'))
        end

        def append_after_restart_file
          append_file('deploy/after_restart.rb') do
            File.read(find_in_source_paths('after_restart.rb'))
          end
        end

        def append_before_symlink_file
          append_file('deploy/before_symlink.rb') do
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
              "newrelic": { "api_key": "<your api key>" } to the platform
              configuration.'
          else
            'Please run "rake cms:cloud_config:edit" to remove
              "newrelic": { "api_key": "<your api key>" } from the platform
              configuration.'
          end

          log(:config, notice)
        end
      end
    end
  end
end