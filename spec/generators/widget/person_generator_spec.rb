require 'spec_helper'

require 'generator_spec/test_case'
require 'rails/generators/test_case'
require 'generators/cms/widget/person/person_generator.rb'
require 'generators/cms/attribute/attribute_generator'
require 'generators/cms/model/model_generator'

describe Cms::Generators::Widget::PersonGenerator do
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
  end

  it 'creates files' do
    destination_root.should have_structure {
      directory 'app' do
        directory 'cells' do
          directory 'box' do
            file 'box_person_cell.rb'

            directory 'box_person' do
              file 'show.html.haml'
              file 'name.html.haml'
              file 'email.html.haml'
            end
          end
        end

        directory 'models' do
          file 'box_person.rb' do
            contains 'include Box'
            contains 'include Cms::Attributes::Person'
            contains 'include Cms::Attributes::SortKey'
          end
        end

        directory 'concerns' do
          directory 'cms' do
            directory 'attributes' do
              file 'sort_key.rb'
              file 'person.rb'
            end
          end
        end
      end

      directory 'cms' do
        directory 'migrate' do
          migration 'create_box_person'
          migration 'create_box_person_example'
        end
      end
    }
  end
end