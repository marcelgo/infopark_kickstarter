require 'spec_helper'

require 'generator_spec/test_case'
require 'generators/cms/model/model_generator'

describe Cms::Generators::ModelGenerator do
  include GeneratorSpec::TestCase

  destination File.expand_path('../../../tmp', __FILE__)
  arguments ['news', '--title=Test News Title', '--type=generic', '--attributes=foo', 'bar', '--mandatory_attributes=foo', 'bar', '--preset_attributes=foo:f', 'bar:b']

  before do
    prepare_destination
    run_generator
  end

  it 'generates news model' do
    destination_root.should have_structure {
      directory 'app' do
        directory 'models' do
          file 'news.rb' do
            contains 'class News < Obj'
            contains '# include Page'
            contains '# include Box'
            contains '# include Resource'
          end
        end
      end
    }
  end

  it 'creates migration file' do
    destination_root.should have_structure {
      directory 'cms' do
        directory 'migrate' do
          migration 'create_news' do
            contains "name: 'News'"
            contains "title: 'Test News Title'"
            contains "type: 'generic'"
            contains 'attributes: ["foo", "bar"]'
            contains 'mandatory_attributes: ["foo", "bar"]'
            contains 'preset_attributes: {"foo"=>"f", "bar"=>"b"}'
          end
        end
      end
    }
  end
end