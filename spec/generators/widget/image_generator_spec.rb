require 'spec_helper'

require 'generator_spec/test_case'
require 'rails/generators/test_case'
require 'generators/cms/widget/image/image_generator.rb'
require 'generators/cms/attribute/attribute_generator'
require 'generators/cms/model/model_generator'

describe Cms::Generators::Widget::ImageGenerator do
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
            file 'box_image_cell.rb'

            directory 'box_image' do
              file 'show.html.haml'
              file 'image_with_link.html.haml'
              file 'image_without_link.html.haml'
            end
          end
        end

        directory 'models' do
          file 'box_image.rb' do
            contains 'include Cms::Attributes::SortKey'
            contains 'include Cms::Attributes::Caption'
            contains 'include Cms::Attributes::Source'
            contains 'include Cms::Attributes::LinkTo'
            contains 'include Box'
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
          migration 'create_box_image'
          migration 'create_image_widget_example'
        end
      end

      directory 'spec' do
        directory 'models' do
          file 'box_image_spec.rb'
        end
      end
    }
  end
end