require 'spec_helper'

require 'generator_spec/test_case'
require 'generators/cms/component/profile_page/profile_page_generator.rb'
require 'generators/cms/attribute/api/api_generator'
require 'generators/cms/model/api/api_generator'

describe Cms::Generators::Component::ProfilePageGenerator do
  include GeneratorSpec::TestCase

  destination File.expand_path('../../../../tmp/generators', __FILE__)
  arguments ['--skip_translation_import']

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
      cells: "#{destination_root}/app/cells",
      meta_navigation: "#{destination_root}/app/cells/meta_navigation",
    }

    paths.each do |_, path|
      mkdir_p(path)
    end

    File.open("#{destination_root}/Gemfile", 'w')
    File.open("#{paths[:models]}/homepage.rb", 'w') { |f| f.write("class Homepage < Obj\n") }
    File.open("#{paths[:cells]}/meta_navigation_cell.rb", 'w') { |f| f.write("    @current_user = current_user\n") }
    File.open("#{paths[:meta_navigation]}/show.html.haml", 'w') { |f| f.write("      = t('.meta')\n") }
  end

  it 'creates files' do
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

      directory 'spec' do
        directory 'models' do
          file 'profile_page_spec.rb'
        end
      end

      file 'Gemfile' do
        contains 'valid_email'
        contains 'localized_country_select'
      end
    }
  end
end