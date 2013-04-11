require 'spec_helper'

require 'generator_spec/test_case'
require 'rails/generators/test_case'
require 'generators/cms/widget/text/text_generator.rb'
require 'generators/cms/attribute/api/api_generator'
require 'generators/cms/model/api/api_generator'

describe Cms::Generators::Widget::TextGenerator do
  include GeneratorSpec::TestCase

  destination File.expand_path('../../../../tmp', __FILE__)

  arguments ['--example']

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
        directory 'widgets' do
          directory 'text_widget' do
            file 'show.html.haml'
            file 'thumbnail.html.haml'

            directory 'locales' do
              file 'de.text_widget.yml'
              file 'en.text_widget.yml'
            end
          end
        end

        directory 'models' do
          file 'text_widget.rb' do
            contains 'include Cms::Attributes::SortKey'
            contains 'include Widget'
          end
        end

        directory 'concerns' do
          directory 'cms' do
            directory 'attributes' do
              file 'sort_key.rb'
            end
          end
        end
      end

      directory 'cms' do
        directory 'migrate' do
          migration 'create_text_widget'
          migration 'create_text_widget_example'
        end
      end
    }
  end
end