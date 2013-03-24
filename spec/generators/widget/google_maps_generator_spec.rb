require 'spec_helper'

require 'generator_spec/test_case'
require 'generators/cms/widget/google_maps/google_maps_generator.rb'
require 'generators/cms/attribute/attribute_generator'
require 'generators/cms/model/model_generator'

describe Cms::Generators::Widget::GoogleMapsGenerator do
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
    layouts_environments_path = "#{destination_root}/app/views/layouts"
    javascripts_environments_path = "#{destination_root}/app/assets/javascripts"
    config_environments_path = "#{destination_root}/config"

    mkdir_p(layouts_environments_path)
    mkdir_p(javascripts_environments_path)
    mkdir_p(config_environments_path)

    File.open("#{layouts_environments_path}/application.html.haml", 'w') { |f| f.write("= javascript_include_tag('application')") }
    File.open("#{javascripts_environments_path}/application.js", 'w') { |f| f.write("//= require infopark_rails_connector\n") }
    File.open("#{destination_root}/Gemfile", 'w')
    File.open("#{config_environments_path}/routes.rb", 'w')
  end

  it 'creates files' do
    destination_root.should have_structure {
      directory 'app' do
        directory 'assets' do
          directory 'javascripts' do
            file 'application.js' do
              contains "new GoogleMap.App('.google_maps .map');"
            end

            directory 'google_maps' do
              file 'app.js.coffee'

              directory 'model' do
                file 'map.js.coffee'
                file 'pin.js.coffee'
              end
            end
          end

          directory 'stylesheets' do
            file 'google_maps.css.scss'
          end
        end

        directory 'cells' do
          directory 'box' do
            file 'box_google_maps_cell.rb'

            directory 'box_google_maps' do
              file 'show.html.haml'
            end
          end
        end

        directory 'models' do
          file 'box_google_maps.rb'
          file 'google_maps_pin.rb'
        end

        directory 'controllers' do
          file 'google_maps_controller.rb'
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
          migration 'create_box_google_maps'
          migration 'create_box_google_maps_example'
        end
      end

      directory 'spec' do
        directory 'models' do
          file 'box_google_maps_spec.rb'
          file 'google_maps_pin_spec.rb'
        end
      end

      file 'Gemfile' do
        contains 'gem "geocoder"'
      end
    }
  end
end