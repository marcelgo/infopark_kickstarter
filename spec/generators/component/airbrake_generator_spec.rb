require 'spec_helper'

require 'generator_spec/test_case'
require 'generators/cms/component/airbrake/airbrake_generator'

describe Cms::Generators::Component::AirbrakeGenerator do
  include GeneratorSpec::TestCase

  destination File.expand_path('../../../../tmp', __FILE__)

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

  it 'appends custom cloud file' do
    destination_root.should have_structure {
      directory 'config' do
        file 'custom_cloud.yml' do
          contains 'airbrake:'
          contains "  api_key: ''"
        end
      end
    }
  end

  it 'creates initializer file' do
    destination_root.should have_structure {
      directory 'config' do
        directory 'initializers' do
          file 'airbrake.rb' do
            contains "configuration = YAML.load_file(Rails.root + 'config/custom_cloud.yml')"
            contains "config.api_key = configuration['airbrake']['api_key']"
            contains 'config.secure = true'
          end
        end
      end
    }
  end

  it 'appends deploy file' do
    destination_root.should have_structure {
      directory 'deploy' do
        file 'after_restart.rb' do
          contains 'run "bundle exec rake environment airbrake:deploy TO=#{new_resource.environment[\'RAILS_ENV\']}"'
        end
      end
    }
  end

  it 'adds gem' do
    destination_root.should have_structure {
      file 'Gemfile' do
        contains 'gem "airbrake"'
      end
    }
  end
end