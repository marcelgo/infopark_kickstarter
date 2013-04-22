require 'spec_helper'

require 'generator_spec/test_case'
require 'generators/cms/component/redirect/redirect_generator.rb'
require 'generators/cms/attribute/api/api_generator'
require 'generators/cms/model/api/api_generator'

describe Cms::Generators::Component::RedirectGenerator do
  include GeneratorSpec::TestCase

  destination File.expand_path('../../../../tmp/generators', __FILE__)

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
          file 'redirect.rb' do
            contains 'include Cms::Attributes::ShowInNavigation'
            contains 'include Cms::Attributes::SortKey'
            contains 'include Cms::Attributes::RedirectLink'
          end
        end

        directory 'controllers' do
          file 'redirect_controller.rb'
        end

        directory 'concerns' do
          directory 'cms' do
            directory 'attributes' do
              file 'redirect_link.rb'
              file 'show_in_navigation.rb'
              file 'sort_key.rb'
            end
          end
        end
      end

      directory 'config' do
        directory 'locales' do
          file 'en.redirect.yml'
          file 'de.redirect.yml'
        end
      end

      directory 'cms' do
        directory 'migrate' do
          migration 'create_redirect'
        end
      end
    }
  end
end