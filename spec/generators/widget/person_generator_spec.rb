require 'spec_helper'

require 'generator_spec/test_case'
require 'rails/generators/test_case'
require 'generators/cms/widget/person/person_generator.rb'
require 'generators/cms/attribute/attribute_generator'
require 'generators/cms/model/model_generator'

describe Cms::Generators::Widget::PersonGenerator do
  include GeneratorSpec::TestCase

  destination File.expand_path('../../../../tmp', __FILE__)

  arguments ['--example']

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
        directory 'widgets' do
          directory 'person_widget' do
            file 'show.html.haml'
            file 'thumbnail.html.haml'
          end
        end

        directory 'models' do
          file 'person_widget.rb' do
            contains 'include Widget'
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
          migration 'create_person_widget'
          migration 'create_person_widget_example'
        end
      end
    }
  end
end