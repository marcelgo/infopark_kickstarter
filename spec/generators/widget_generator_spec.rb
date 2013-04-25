require 'spec_helper'

require 'generator_spec/test_case'
require 'generators/cms/widget/widget_generator'
require 'generators/cms/model/api/api_generator'
require 'generators/cms/attribute/api/api_generator'

describe Cms::Generators::WidgetGenerator do
  include GeneratorSpec::TestCase

  destination File.expand_path('../../../tmp/generators', __FILE__)
  arguments ['news_widget', '--title=Test News Title', '--description=Test News Description', '--attributes=foo:html', 'bar:enum', '--mandatory_attributes=foo', 'bar', '--preset_attributes=foo:f', 'bar:b']

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
        directory 'concerns' do
          directory 'cms' do
            directory 'attributes' do
              file 'foo.rb'
              file 'bar.rb'
            end
          end
        end

        directory 'models' do
          file 'news_widget.rb' do
            contains 'class NewsWidget < Obj'
            contains 'include Widget'
          end
        end

        directory 'widgets' do
          directory 'news_widget' do
            file 'show.html.haml'
            file 'thumbnail.html.haml'

            directory 'locales' do
              file 'en.news_widget.yml' do
                contains "title: 'Test News Title'"
                contains "description: 'Test News Description'"
              end

              file 'de.news_widget.yml' do
                contains "title: 'Test News Title'"
                contains "description: 'Test News Description'"
              end
            end

            directory 'migrate' do
              migration 'create_news_widget' do
                contains "name: 'NewsWidget'"
                contains "title: 'Test News Title'"
                contains "type: 'publication'"
                contains '{:name=>"foo", :type=>"html"},'
                contains '{:name=>"bar", :type=>"enum"},'
                contains 'mandatory_attributes: ["foo", "bar"]'
                contains 'preset_attributes: {"foo"=>"f", "bar"=>"b"}'
              end
            end
          end
        end
      end
    }
  end
end