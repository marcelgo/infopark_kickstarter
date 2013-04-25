require 'spec_helper'

require 'generator_spec/test_case'
require 'generators/cms/component/profile_page/profile_page_generator.rb'
require 'generators/cms/attribute/api/api_generator'
require 'generators/cms/model/api/api_generator'

describe Cms::Generators::Component::ProfilePageGenerator do
  include GeneratorSpec::TestCase

  destination File.expand_path('../../../../tmp/generators', __FILE__)
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

  it 'creates files' do
    destination_root.should have_structure {
      directory 'app' do
        directory 'models' do
          file 'profile_page.rb'
        end

        directory 'presenters' do
          file 'profile_page_presenter.rb'
        end

        directory 'controllers' do
          file 'profile_page_controller.rb'
        end

        directory 'concerns' do
          directory 'cms' do
            directory 'attributes' do
              file 'sort_key.rb'
              file 'show_in_navigation.rb'
              file 'headline.rb'
              file 'content.rb'
            end
          end
        end
      end

      directory 'config' do
        directory 'locales' do
          file 'de.profile_page.yml'
          file 'en.profile_page.yml'
        end
      end

      directory 'cms' do
        directory 'migrate' do
          migration 'create_profile_page'
          migration 'create_profile_page_example'
        end
      end
    }
  end
end