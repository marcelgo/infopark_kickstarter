require 'spec_helper'

require 'generator_spec/test_case'
require 'generators/cms/component/profile_page/profile_page_generator.rb'
require 'generators/cms/attribute/attribute_generator'
require 'generators/cms/model/model_generator'

describe Cms::Generators::Component::ProfilePageGenerator do
  include GeneratorSpec::TestCase

  destination File.expand_path('../../../../tmp', __FILE__)

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
      meta_navigation: "#{destination_root}/app/cells/meta_navigation",
    }

    paths.each do |_, path|
      mkdir_p(path)
    end

    File.open("#{destination_root}/Gemfile", 'w')
    File.open("#{paths[:models]}/homepage.rb", 'w') { |f| f.write("class Homepage < Obj\n") }
    File.open("#{paths[:cells]}/meta_navigation_cell.rb", 'w') { |f| f.write("@search_page = page.homepage.search_page\n") }
    File.open("#{paths[:meta_navigation]}/show.html.haml", 'w') { |f| f.write('= display_title(@search_page)') }
  end

  it 'adds gems' do
    destination_root.should have_structure {
      file 'Gemfile' do
        contains 'valid_email'
        contains 'localized_country_select'
      end
    }
  end

  it 'creates app file' do
    destination_root.should have_structure {
      directory 'app' do
        directory 'models' do
          file 'profile_page.rb'

          file 'homepage.rb' do
            contains 'include Cms::Attributes::ProfilePageLink'
          end
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
              file 'profile_page_link.rb'
            end
          end
        end

        directory 'cells' do
          file 'meta_navigation_cell.rb' do
            contains '@profile_page = page.homepage.profile_page'
          end

          directory 'meta_navigation' do
            file 'show.html.haml' do
              contains '= display_title(@profile_page)'
            end
          end
        end
      end
    }
  end

  it 'creates locales file' do
    destination_root.should have_structure {
      directory 'config' do
        directory 'locales' do
          file 'de.profile_page.yml'
          file 'en.profile_page.yml'
        end
      end
    }
  end

  it 'creates test files' do
    destination_root.should have_structure {
      directory 'spec' do
        directory 'models' do
          file 'profile_page_spec.rb'
        end
      end
    }
  end

  it 'creates migration files' do
    destination_root.should have_structure {
      directory 'cms' do
        directory 'migrate' do
          migration 'create_profile_page'
          migration 'create_profile_page_example'
        end
      end
    }
  end
end