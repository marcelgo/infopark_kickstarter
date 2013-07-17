require 'spec_helper'

require 'generator_spec/test_case'
require 'generators/cms/component/tour/tour_generator.rb'

describe Cms::Generators::Component::TourGenerator do
  include GeneratorSpec::TestCase

  destination File.expand_path('../../../../tmp/generators', __FILE__)
  arguments ['--example']

  before do
    prepare_destination
    prepare_environments
    run_generator
  end

  def prepare_environments
    paths = {
      layouts_path: "#{destination_root}/app/views/layouts",
      javascripts_path: "#{destination_root}/app/assets/javascripts",
      stylesheets_path: "#{destination_root}/app/assets/stylesheets",
    }

    paths.each do |_, path|
      mkdir_p(path)
    end

    File.open("#{paths[:layouts_path]}/application.html.haml", 'w') { |f| f.write('      = render_cell(:footer, :show, @obj)') }
    File.open("#{paths[:javascripts_path]}/application.js", 'w') { |f| f.write('//= require infopark_rails_connector') }
    File.open("#{paths[:stylesheets_path]}/application.css", 'w') { |f| f.write('*= require infopark_rails_connector') }
  end

  it 'creates file' do
    destination_root.should have_structure {
      directory 'app' do
        directory 'assets' do
          directory 'javascripts' do
            file 'infopark_tour.js.coffee'
            file 'infopark_tour.config.js.coffee'
          end

          directory 'stylesheets' do
            file 'infopark_tour.css.less'
          end
        end

        directory 'views' do
          directory 'layouts' do
            file 'application.html.haml' do
              contains "render 'tour/tour'"
            end
          end

          directory 'tour' do
            file '_tour.html.haml'
          end
        end
      end

      directory 'cms' do
        directory 'migrate' do
          migration 'create_tour_example'
        end
      end
    }
  end
end