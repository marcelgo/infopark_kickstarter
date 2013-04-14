require 'spec_helper'

require 'generator_spec/test_case'
require 'rails/generators/test_case'
require 'generators/cms/widget/image/image_generator.rb'
require 'generators/cms/attribute/api/api_generator'
require 'generators/cms/model/api/api_generator'

describe Cms::Generators::Widget::ImageGenerator do
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
  end

  it 'creates files' do
    destination_root.should have_structure {
      directory 'app' do
        directory 'widgets' do
          directory 'image_widget' do
            file 'show.html.haml'
            file 'thumbnail.html.haml'

            directory 'locales' do
              file 'de.image_widget.yml'
              file 'en.image_widget.yml'
            end
          end
        end

        directory 'models' do
          file 'image_widget.rb' do
            contains 'include Cms::Attributes::SortKey'
            contains 'include Cms::Attributes::Caption'
            contains 'include Cms::Attributes::Source'
            contains 'include Cms::Attributes::LinkTo'
            contains 'include Widget'
          end
        end

        directory 'concerns' do
          directory 'cms' do
            directory 'attributes' do
              file 'sort_key.rb'
              file 'caption.rb'
              file 'source.rb'
              file 'link_to.rb'
            end
          end
        end
      end

      directory 'cms' do
        directory 'migrate' do
          migration 'create_image_widget'
        end
      end
    }
  end
end