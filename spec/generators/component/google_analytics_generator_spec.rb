require 'spec_helper'

require 'generator_spec/test_case'
require 'generators/cms/component/google_analytics/google_analytics_generator.rb'
require 'generators/cms/attribute/attribute_generator'
require 'generators/cms/model/model_generator'

describe Cms::Generators::Component::GoogleAnalyticsGenerator do
  include GeneratorSpec::TestCase

  destination File.expand_path('../../../../tmp', __FILE__)
  arguments ['--anonymize_ip_default=Yes', '--tracking_id_default=1234']

  before(:all) do
    Cms::Generators::AttributeGenerator.send(:include, TestDestinationRoot)
    Cms::Generators::ModelGenerator.send(:include, TestDestinationRoot)
  end

  before do
    prepare_destination
    prepare_environments
    run_generator
  end

  def prepare_environments
    environments_path = "#{destination_root}/app/views/layouts/"

    mkdir_p(environments_path)

    File.open("#{environments_path}application.html.haml", 'w') { |f| f.write("= javascript_include_tag 'application'") }
  end

  it 'creates view' do
    destination_root.should have_structure {
      directory 'app' do
        directory 'cells' do
          file 'google_analytics_cell.rb'

          directory 'google_analytics' do
            file 'show.html.erb'
          end
        end
      end
    }
  end

  it 'creates model file' do
    destination_root.should have_structure {
      directory 'app' do
        directory 'models' do
          file 'google_analytics.rb'
        end
      end
    }
  end

  it 'creates test file' do
    destination_root.should have_structure {
      directory 'spec' do
        directory 'models' do
          file 'google_analytics_spec.rb'
        end
      end
    }
  end

  it 'creates migration file' do
    destination_root.should have_structure {
      directory 'cms' do
        directory 'migrate' do
          migration 'create_google_analytics'

          migration 'integrate_google_analytics' do
            contains "'google_analytics_tracking_id' => '1234'"
            contains "'google_analytics_anonymize_ip' => 'Yes'"
          end
        end
      end
    }
  end
end