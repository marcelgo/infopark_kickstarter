require 'spec_helper'

require 'generator_spec/test_case'
require 'generators/cms/component/google_analytics/google_analytics_generator.rb'
require 'generators/cms/attribute/api/api_generator'
require 'generators/cms/model/api/api_generator'

describe Cms::Generators::Component::GoogleAnalyticsGenerator do
  include GeneratorSpec::TestCase

  destination File.expand_path('../../../../tmp', __FILE__)
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
    environments_path = "#{destination_root}/app/views/layouts/"

    mkdir_p(environments_path)

    File.open("#{environments_path}application.html.haml", 'w') { |f| f.write("= javascript_include_tag 'application'") }
  end

  it 'creates files' do
    destination_root.should have_structure {
      directory 'app' do
        directory 'models' do
          file 'google_analytics.rb'
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
          migration 'create_google_analytics' do
            contains '"google_analytics_tracking_id"=>"1234"'
            contains '"google_analytics_anonymize_ip"=>"Yes"'
          end

          migration 'integrate_google_analytics'
        end
      end

      directory 'spec' do
        directory 'models' do
          file 'google_analytics_spec.rb'
        end
      end
    }
  end
end