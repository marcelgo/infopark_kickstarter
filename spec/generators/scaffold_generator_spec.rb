require 'spec_helper'

require 'generator_spec/test_case'
require 'generators/cms/scaffold/scaffold_generator'
require 'generators/cms/attribute/api/api_generator'
require 'generators/cms/model/api/api_generator'

describe Cms::Generators::ScaffoldGenerator do
  include GeneratorSpec::TestCase

  destination File.expand_path('../../../tmp/generators', __FILE__)
  arguments ['news']

  before(:all) do
    Cms::Generators::Attribute::ApiGenerator.send(:include, TestDestinationRoot)
    Cms::Generators::Model::ApiGenerator.send(:include, TestDestinationRoot)
  end

  before do
    prepare_destination
    run_generator
  end

  it 'generates scaffold files' do
    destination_root.should have_structure {
      directory 'app' do
        directory 'models' do
          file 'news.rb' do
            contains 'class News < Obj'
          end
        end

        directory 'controllers' do
          file 'news_controller.rb' do
            contains 'class NewsController < CmsController'
          end
        end

        directory 'views' do
          directory 'news' do
            file 'index.html.haml'
          end
        end
      end
    }
  end
end