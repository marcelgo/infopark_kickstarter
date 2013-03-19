require 'spec_helper'

require 'generator_spec/test_case'
require 'rails/generators/test_case'
require 'generators/cms/widget/contact/contact_generator.rb'
require 'generators/cms/attribute/attribute_generator'
require 'generators/cms/model/model_generator'

describe Cms::Generators::Widget::ContactGenerator do
  include GeneratorSpec::TestCase

  destination File.expand_path('../../../../tmp', __FILE__)

  arguments ['--cms_path=testdirectory']

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
    javascripts_path = "#{destination_root}/app/assets/javascripts"
    stylesheets_path = "#{destination_root}/app/assets/stylesheets"

    mkdir_p(javascripts_path)
    mkdir_p(stylesheets_path)

    File.open("#{javascripts_path}/application.js", 'w') { |file| file.write("//= require infopark_rails_connector\n") }
    File.open("#{stylesheets_path}/application.css", 'w') { |file| file.write("*= require infopark_rails_connector\n") }
    File.open("#{destination_root}/Gemfile", 'w')
  end

  it 'creates app files' do
    destination_root.should have_structure {
      directory 'app' do
        directory 'cells' do
          directory 'box' do
            file 'box_contact_cell.rb'

            directory 'box_contact' do
              file 'show.html.haml'
            end
          end
        end

        directory 'models' do
          file 'box_contact.rb' do
            contains 'include Box'
            contains 'include Cms::Attributes::ContactId'
            contains 'include Cms::Attributes::SortKey'
          end
        end

        directory 'concerns' do
          directory 'cms' do
            directory 'attributes' do
              file 'sort_key.rb'
              file 'contact_id.rb'
            end
          end
        end

        directory 'assets' do
          directory 'stylesheets' do
              file 'box_contact.css.scss'
          end
        end
      end
    }
  end

  it 'creates test files' do
    destination_root.should have_structure {
      directory 'spec' do
        directory 'models' do
          file 'box_contact_spec.rb'
        end
      end
    }
  end

  it 'creates migration files' do
    destination_root.should have_structure {
      directory 'cms' do
        directory 'migrate' do
          migration 'create_box_contact'
          migration 'create_box_contact_example'
        end
      end
    }
  end
end