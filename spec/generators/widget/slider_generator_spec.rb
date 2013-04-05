require 'spec_helper'

require 'generator_spec/test_case'
require 'rails/generators/test_case'
require 'generators/cms/widget/slider/slider_generator.rb'
require 'generators/cms/attribute/api/api_generator'
require 'generators/cms/model/api/api_generator'

describe Cms::Generators::Widget::SliderGenerator do
  include GeneratorSpec::TestCase

  destination File.expand_path('../../../../tmp', __FILE__)

  arguments ['--cms_path=testdirectory']

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
        directory 'cells' do
          directory 'box' do
            file 'box_slider_cell.rb'

            directory 'box_slider' do
              file 'show.html.haml'
              file 'image.html.haml'
              file 'images.html.haml'
              file 'indicators.html.haml'
              file 'left_control.html.haml'
              file 'right_control.html.haml'
              file 'title.html.haml'
            end
          end
        end

        directory 'models' do
          file 'box_slider.rb' do
            contains 'include Box'
            contains 'include Cms::Attributes::SortKey'
            contains 'include Cms::Attributes::SliderImages'
          end
        end

        directory 'concerns' do
          directory 'cms' do
            directory 'attributes' do
              file 'sort_key.rb'
              file 'slider_images.rb'
            end
          end
        end
      end

      directory 'cms' do
        directory 'migrate' do
          migration 'create_box_slider'
          migration 'create_box_slider_example'
        end
      end

      directory 'spec' do
        directory 'models' do
          file 'box_slider_spec.rb'
        end
      end
    }
  end
end