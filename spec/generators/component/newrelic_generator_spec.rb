require 'spec_helper'

require 'generator_spec/test_case'
require 'generators/cms/component/newrelic/newrelic_generator'

describe Cms::Generators::Component::NewrelicGenerator do
  include GeneratorSpec::TestCase

  destination File.expand_path('../../../../tmp', __FILE__)
  arguments ['Test Website']

  before do
    prepare_destination
    prepare_environments
    run_generator
  end

  def prepare_environments
    config_path = "#{destination_root}/config"
    deploy_path = "#{destination_root}/deploy"
    initializers_path = "#{config_path}/initializers"

    mkdir_p(initializers_path)
    mkdir_p(deploy_path)

    File.open("#{destination_root}/Gemfile", 'w')
    File.open("#{config_path}/custom_cloud.yml", 'w')
    File.open("#{deploy_path}/after_restart.rb", 'w')
    File.open("#{deploy_path}/before_symlink.rb", 'w')
  end

  it 'appends custom cloud file' do
    destination_root.should have_structure {
      directory 'config' do
        file 'custom_cloud.yml' do
          contains 'newrelic:'
          contains "  api_key: ''"
        end
      end
    }
  end

  it 'creates newrelic configuration file' do
    destination_root.should have_structure {
      directory 'deploy' do
        directory 'templates' do
          file 'newrelic.yml.erb'
        end
      end
    }
  end

  it 'adds gem' do
    destination_root.should have_structure {
      file 'Gemfile' do
        contains 'gem "newrelic_rpm"'
      end
    }
  end
end