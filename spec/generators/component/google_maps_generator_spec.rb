require 'spec_helper'

require 'generator_spec/test_case'
require 'generators/cms/component/google_maps/google_maps_generator.rb'

describe Cms::Generators::Component::GoogleMapsGenerator do
  include GeneratorSpec::TestCase

  destination File.expand_path('../../../../tmp', __FILE__)

  arguments ['--cms_path=testdirectory']

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

  it 'creates app files' do
    destination_root.should have_structure {
      directory 'app' do
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
              file 'latitude.rb'
              file 'longitude.rb'
            end
          end
        end
      end
    }
  end

  it 'creates test files' do
    destination_root.should have_structure {
      directory 'spec' do
        directory 'models' do
          file 'box_google_maps_spec.rb'
          file 'google_maps_pin_spec.rb'
        end
      end
    }
  end

  it 'creates migration files' do
    destination_root.should have_structure {
      directory 'cms' do
        directory 'migrate' do
          migration 'create_google_maps'
          migration 'create_google_maps_example'
        end
      end
    }
  end

  it 'creates asset files' do
    destination_root.should have_structure {
      directory 'app' do
        directory 'assets' do
          directory 'javascripts' do
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
      end
    }
  end
end