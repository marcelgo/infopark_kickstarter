require 'spec_helper'

require 'generator_spec/test_case'
require 'generators/cms/component/contact_page/contact_page_generator.rb'
require 'generators/cms/attribute/api/api_generator'
require 'generators/cms/model/api/api_generator'

describe Cms::Generators::Component::ContactPageGenerator do
  include GeneratorSpec::TestCase

  destination File.expand_path('../../../../tmp', __FILE__)

  arguments ['--cms_path=/website/en']

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
  end

  it 'creates file' do
    destination_root.should have_structure {
      directory 'app' do
        directory 'models' do
          file 'contact_page.rb'
        end

        directory 'presenters' do
          file 'contact_page_presenter.rb'
        end

        directory 'services' do
          file 'contact_activity_service.rb'
        end

        directory 'concerns' do
          directory 'cms' do
            directory 'attributes' do
              file 'crm_activity_type.rb'
              file 'sort_key.rb'
              file 'show_in_navigation.rb'
            end
          end
        end
      end

      directory 'config' do
        directory 'locales' do
          file 'en.contact_page.yml'
          file 'de.contact_page.yml'
        end
      end

      directory 'cms' do
        directory 'migrate' do
          migration 'create_contact_page'
          migration 'create_contact_page_example'
        end
      end
    }
  end
end