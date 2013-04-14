require 'spec_helper'

require 'generator_spec/test_case'
require 'generators/cms/component/search/search_generator.rb'
require 'generators/cms/attribute/api/api_generator'
require 'generators/cms/model/api/api_generator'

describe Cms::Generators::Component::SearchGenerator do
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
    paths = {
      models: "#{destination_root}/app/models",
      layouts: "#{destination_root}/app/views/layouts",
    }

    paths.each do |_, path|
      mkdir_p(path)
    end

    File.open("#{paths[:models]}/homepage.rb", 'w') { |f| f.write("class Homepage < Obj\n") }
    File.open("#{paths[:layouts]}/application.html.haml", 'w') { |f| f.write("          .span3\n") }
  end

  it 'creates files' do
    destination_root.should have_structure {
      directory 'app' do
        directory 'models' do
          file 'search_page.rb' do
            contains 'include Cms::Attributes::ShowInNavigation'
            contains '  include Page'
          end

          file 'homepage.rb' do
            contains 'include Cms::Attributes::SearchPageLink'
          end
        end

        directory 'views' do
          directory 'search_page' do
            file 'index.html.haml' do
              contains 'render_cell(:search, :results, @query, @hits)'
            end
          end

          directory 'layouts' do
            file 'application.html.haml' do
              contains 'render_cell(:search, :form, @obj, @query)'
            end
          end
        end

        directory 'controllers' do
          file 'search_page_controller.rb'
        end

        directory 'concerns' do
          directory 'cms' do
            directory 'attributes' do
              file 'search_page_link.rb'
              file 'show_in_navigation.rb'
            end
          end
        end

        directory 'cells' do
          file 'search_cell.rb'

          directory 'search' do
            file 'form.html.haml'
            file 'hit.html.haml'
            file 'hits.html.haml'
            file 'no_hits.html.haml'
          end
        end
      end

      directory 'config' do
        directory 'locales' do
          file 'en.search.yml'
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