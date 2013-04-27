require 'spec_helper'

require 'generator_spec/test_case'
require 'rails/generators/test_case'
require 'generators/cms/widget/person/person_generator.rb'
require 'generators/cms/attribute/api/api_generator'
require 'generators/cms/model/api/api_generator'
require 'generators/cms/widget/api/api_generator'

describe Cms::Generators::Widget::PersonGenerator do
  include GeneratorSpec::TestCase

  destination File.expand_path('../../../../tmp/generators', __FILE__)

  before(:all) do
    Cms::Generators::Attribute::ApiGenerator.send(:include, TestDestinationRoot)
    Cms::Generators::Model::ApiGenerator.send(:include, TestDestinationRoot)
    Cms::Generators::Widget::ApiGenerator.send(:include, TestDestinationRoot)
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
            directory 'views' do
              file 'show.html.haml'
              file 'thumbnail.html.haml'
            end

            directory 'locales' do
              file 'en.person_widget.yml'
            end

            directory 'migrate' do
              migration 'create_person_widget'
            end
          end
        end

        directory 'models' do
          file 'person_widget.rb' do
            contains 'include Widget'
            contains 'include Cms::Attributes::Person'
          end
        end

        directory 'concerns' do
          directory 'cms' do
            directory 'attributes' do
              file 'person.rb'
            end
          end
        end
      end
    }
  end
end