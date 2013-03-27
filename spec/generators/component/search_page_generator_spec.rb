require 'spec_helper'

require 'generator_spec/test_case'
require 'generators/cms/component/search_page/search_page_generator.rb'
require 'generators/cms/attribute/attribute_generator'
require 'generators/cms/model/model_generator'

describe Cms::Generators::Component::SearchPageGenerator do
  include GeneratorSpec::TestCase

  destination File.expand_path('../../../../tmp', __FILE__)
  arguments ['--skip_translation_import']

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
    paths = {
      models: "#{destination_root}/app/models",
      cells: "#{destination_root}/app/cells",
    }

    paths.each do |_, path|
      mkdir_p(path)
    end

    File.open("#{paths[:models]}/homepage.rb", 'w') { |f| f.write("class Homepage < Obj\n") }
  end

  it 'creates files' do
    destination_root.should have_structure {
      directory 'app' do
        directory 'models' do
          file 'search_page.rb'

          file 'homepage.rb' do
            contains 'include Cms::Attributes::SearchPageLink'
          end
        end

        directory 'controllers' do
          file 'search_page_controller.rb'
        end

        directory 'concerns' do
          directory 'cms' do
            directory 'attributes' do
              file 'search_page_link.rb'
            end
          end
        end

        directory 'cells' do
        end
      end

      directory 'config' do
        directory 'locales' do
          file 'de.search_page.yml'
          file 'en.search_page.yml'
        end
      end

      directory 'cms' do
        directory 'migrate' do
          migration 'create_search_page'
          migration 'create_search_page_example'
        end
      end

      directory 'spec' do
        directory 'models' do
          file 'search_page_spec.rb'
        end
        directory 'controllers' do
          file 'search_page_controller_spec.rb'
        end
      end
    }
  end
end