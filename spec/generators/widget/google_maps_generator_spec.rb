require 'spec_helper'

require 'generator_spec/test_case'
require 'generators/cms/widget/google_maps/google_maps_generator.rb'
require 'generators/cms/attribute/attribute_generator'
require 'generators/cms/model/model_generator'

describe Cms::Generators::Widget::GoogleMapsGenerator do
  include GeneratorSpec::TestCase

  destination File.expand_path('../../../../tmp', __FILE__)

  arguments ['--example']

  before(:all) do
    Cms::Generators::AttributeGenerator.send(:include, TestDestinationRoot)
    Cms::Generators::ModelGenerator.send(:include, TestDestinationRoot)
  end

  before do
    prepare_destination
    run_generator
  end

  it 'creates files' do
    destination_root.should have_structure {
      directory 'app' do
        directory 'assets' do

          directory 'stylesheets' do
            file 'google_maps.css.scss'
          end
        end

        directory 'widgets' do
          directory 'google_maps_widget' do
            file 'show.html.haml'
            file '_map.html.haml'
            file 'thumbnail.html.haml'
          end
        end

        directory 'models' do
          file 'google_maps_widget.rb'
        end

        directory 'concerns' do
          directory 'cms' do
            directory 'attributes' do
              file 'google_maps_map_type.rb'
              file 'google_maps_address.rb'
            end
          end
        end
      end

      directory 'cms' do
        directory 'migrate' do
          migration 'create_google_maps_widget'
          migration 'create_google_maps_widget_example'
        end
      end

      directory 'spec' do
        directory 'models' do
          file 'google_maps_widget_spec.rb'
        end
      end

    }
  end
end