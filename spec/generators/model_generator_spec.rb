require 'spec_helper'

require 'generator_spec/test_case'
require 'generators/cms/model/model_generator'
require 'generators/cms/model/api/api_generator'
require 'generators/cms/attribute/api/api_generator'

describe Cms::Generators::ModelGenerator do
  include GeneratorSpec::TestCase

  destination File.expand_path('../../../tmp', __FILE__)
  arguments ['news', '--title=Test News Title', '--type=generic', '--attributes=foo:html', 'bar:enum', '--mandatory_attributes=foo', 'bar', '--preset_attributes=foo:f', 'bar:b']

  before(:all) do
    Cms::Generators::Model::ApiGenerator.send(:include, TestDestinationRoot)
    Cms::Generators::Attribute::ApiGenerator.send(:include, TestDestinationRoot)
  end

  before do
    prepare_destination
    run_generator
  end

  it 'generates model files' do
    destination_root.should have_structure {
      directory 'app' do
        directory 'models' do
          file 'news.rb' do
            contains 'class News < Obj'
            contains '# include Page'
            contains '# include Widget'
          end
        end

        directory 'concerns' do
          directory 'cms' do
            directory 'attributes' do
              file 'foo.rb' do
                contains "(self[:foo] || 'f').html_safe"
              end

              file 'bar.rb' do
                contains "self[:bar] || 'b'"
              end
            end
          end
        end
      end

      directory 'cms' do
        directory 'migrate' do
          migration 'create_news' do
            contains "name: 'News'"
            contains "title: 'Test News Title'"
            contains "type: 'generic'"
            contains '{:name=>"foo", :type=>"html"},'
            contains '{:name=>"bar", :type=>"enum"},'
            contains 'mandatory_attributes: ["foo", "bar"]'
            contains 'preset_attributes: {"foo"=>"f", "bar"=>"b"}'
          end
        end
      end

      directory 'spec' do
        directory 'models' do
          file 'news_spec.rb'
        end
      end
    }
  end
end