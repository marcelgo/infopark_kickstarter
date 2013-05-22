require 'spec_helper'

require 'generator_spec/test_case'
require 'generators/cms/component/sitemap/sitemap_generator.rb'

describe Cms::Generators::Component::SitemapGenerator do
  include GeneratorSpec::TestCase

  destination File.expand_path('../../../../tmp/generators', __FILE__)

  before do
    prepare_destination
    prepare_environments
    run_generator
  end

  def prepare_environments
    paths = {
      routes_path: "#{destination_root}/config",
    }

    paths.each do |_, path|
      mkdir_p(path)
    end

    File.open("#{paths[:routes_path]}/routes.rb", 'w') { |f| f.write('TestApp::Application.routes.draw do') }
  end

  it 'creates file' do
    destination_root.should have_structure {
      directory 'app' do
        directory 'controllers' do
          file 'sitemap_controller.rb'
        end

        directory 'views' do
          directory 'sitemap' do
            file 'index.xml.builder'
          end
        end
      end

      directory 'config' do
        file 'routes.rb' do
          contains "get 'sitemap.xml', controller: 'sitemap', action: 'index', format: 'xml'"
        end
      end
    }
  end
end