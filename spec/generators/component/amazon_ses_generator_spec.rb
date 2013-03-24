require 'spec_helper'

require 'generator_spec/test_case'
require 'generators/cms/component/amazon_ses/amazon_ses_generator'

describe Cms::Generators::Component::AmazonSesGenerator do
  include GeneratorSpec::TestCase

  destination File.expand_path('../../../../tmp', __FILE__)

  before do
    prepare_destination
    prepare_environments
    run_generator
  end

  def prepare_environments
    environments_path = "#{destination_root}/config/environments"

    mkdir_p(environments_path)

    File.open("#{environments_path}/production.rb", 'a') { |f| f.write('Test::Application.configure do') }
    File.open("#{environments_path}/test.rb", 'a') { |f| f.write('Test::Application.configure do') }
  end

  it 'creates files' do
    destination_root.should have_structure {
      directory 'config' do
        directory 'environments' do
          file 'production.rb' do
            contains 'config.action_mailer.raise_delivery_errors = true'
          end

          file 'test.rb' do
            contains 'config.action_mailer.default_url_options = {'
            contains "host: 'localhost',"
            contains 'port: 3000,'
          end
        end

        directory 'initializers' do
          file 'amazon_ses.rb'
        end
      end
    }
  end
end