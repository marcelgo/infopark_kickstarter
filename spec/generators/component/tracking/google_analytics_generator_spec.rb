require 'spec_helper'

require 'generator_spec/test_case'
require 'generators/cms/component/tracking/google_analytics/google_analytics_generator.rb'
require 'generators/cms/attribute/api/api_generator'
require 'generators/cms/model/api/api_generator'

describe Cms::Generators::Component::Tracking::GoogleAnalyticsGenerator do
  include GeneratorSpec::TestCase

  destination File.expand_path('../../../../../tmp/generators', __FILE__)
  arguments ['--anonymize_ip_default=Yes', '--tracking_id_default=1234']

  before(:all) do
    Cms::Generators::Attribute::ApiGenerator.send(:include, TestDestinationRoot)
    Cms::Generators::Model::ApiGenerator.send(:include, TestDestinationRoot)
  end

  before do
    prepare_destination
    prepare_environments
    run_generator
  end

  def prepare_environments
    layouts_path = "#{destination_root}/app/views/layouts"
    models_path = "#{destination_root}/app/models"

    mkdir_p(layouts_path)
    mkdir_p(models_path)

    File.open("#{layouts_path}/application.html.haml", 'w') { |file| file.write("= javascript_include_tag 'application'") }
    File.open("#{models_path}/homepage.rb", 'w') { |file| file.write("class Homepage < Obj\n") }
  end

  it 'creates files' do
    destination_root.should have_structure {
      directory 'app' do
        directory 'models' do
          file 'google_analytics.rb'
          file 'homepage.rb' do
            contains 'include Cms::Attributes::GoogleAnalyticsLink'
          end
        end

        directory 'cells' do
          file 'google_analytics_cell.rb'

          directory 'google_analytics' do
            file 'show.html.erb'
          end
        end
      end

      directory 'cms' do
        directory 'migrate' do
          migration 'create_google_analytics'
          migration 'create_google_analytics_example'
        end
      end
    }
  end
end