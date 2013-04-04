require 'spec_helper'

require 'generator_spec/test_case'
require 'generators/cms/component/monitoring/newrelic/newrelic_generator'

describe Cms::Generators::Component::Monitoring::NewrelicGenerator do
  include GeneratorSpec::TestCase

  destination File.expand_path('../../../../../tmp', __FILE__)
  arguments ['Test Website']

  before do
    prepare_destination
    prepare_environments
    run_generator
  end

  def prepare_environments
    config_path = "#{destination_root}/config"
    initializers_path = "#{config_path}/initializers"

    mkdir_p(initializers_path)

    File.open("#{destination_root}/Gemfile", 'w')
    File.open("#{config_path}/custom_cloud.yml", 'w')
  end

  it 'creates files' do
    destination_root.should have_structure {
      directory 'config' do
        file 'custom_cloud.yml' do
          contains 'newrelic:'
          contains "  api_key: ''"
          contains "  deploy_key: ''"
        end

        file 'newrelic.yml' do
          contains "license_key: ''"
          contains 'app_name: "Test Website"'
          contains 'app_name: "Test Website (Staging)"'
        end
      end

      directory 'deploy' do
        directory 'templates' do
          file 'newrelic.yml.erb' do
            contains 'app_name: "Test Website"'
            contains 'app_name: "Test Website (Staging)"'
          end
        end

        file 'after_restart.rb' do
          contains "newrelic_app_name = 'Test Website'"
          contains "newrelic_deploy_key = node['custom_cloud']['newrelic']['deploy_key']"
        end
      end

      file 'Gemfile' do
        contains 'gem "newrelic_rpm"'
      end
    }
  end
end