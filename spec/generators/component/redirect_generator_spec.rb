require 'spec_helper'

require 'generator_spec/test_case'
require 'generators/cms/component/redirect/redirect_generator.rb'

describe Cms::Generators::Component::RedirectGenerator do
  include GeneratorSpec::TestCase

  destination File.expand_path('../../../../tmp/generators', __FILE__)

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
            contains 'cms_attribute :show_in_navigation, type: :boolean'
            contains 'cms_attribute :sort_key, type: :string'
            contains 'cms_attribute :redirect_link, type: :linklist, max_size: 1'
          end
        end

        directory 'controllers' do
          file 'redirect_controller.rb'
        end
      end

      directory 'config' do
        directory 'locales' do
          file 'en.redirect.yml'
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