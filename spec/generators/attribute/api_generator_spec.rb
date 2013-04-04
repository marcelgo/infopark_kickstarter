require 'spec_helper'

require 'generator_spec/test_case'
require 'generators/cms/attribute/api/api_generator'

describe Cms::Generators::Attribute::ApiGenerator do
  include GeneratorSpec::TestCase

  destination File.expand_path('../../../../tmp', __FILE__)

  before(:all) do
    Cms::Generators::Attribute::ApiGenerator.send(:include, TestDestinationRoot)
  end

  before do
    prepare_destination
  end

  context 'string attribute' do
    before do
      Cms::Generators::Attribute::ApiGenerator.new do |attribute|
        attribute.name = 'news'
        attribute.type = :string
      end
    end

    it 'generates string attribute' do
      destination_root.should have_structure {
        directory 'app' do
          directory 'concerns' do
            directory 'cms' do
              directory 'attributes' do
                file 'news.rb' do
                  contains 'module Cms'
                  contains 'module Attributes'
                  contains 'module News'
                  contains 'def news'
                  contains "self[:news] || ''"
                end
              end
            end
          end
        end
      }
    end
  end

  context 'text attribute' do
    before do
      Cms::Generators::Attribute::ApiGenerator.new do |attribute|
        attribute.name = 'news_text'
        attribute.type = :text
      end
    end

    it 'generates text attribute' do
      destination_root.should have_structure {
        directory 'app' do
          directory 'concerns' do
            directory 'cms' do
              directory 'attributes' do
                file 'news_text.rb' do
                  contains 'module Cms'
                  contains 'module Attributes'
                  contains 'module NewsText'
                  contains 'def news_text'
                  contains "self[:news_text] || ''"
                end
              end
            end
          end
        end
      }
    end
  end

  context 'enum attribute' do
    before do
      Cms::Generators::Attribute::ApiGenerator.new do |attribute|
        attribute.name = 'news_enum'
        attribute.type = :enum
      end
    end

    it 'generates enum attribute' do
      destination_root.should have_structure {
        directory 'app' do
          directory 'concerns' do
            directory 'cms' do
              directory 'attributes' do
                file 'news_enum.rb' do
                  contains 'module Cms'
                  contains 'module Attributes'
                  contains 'module NewsEnum'
                  contains 'def news_enum'
                  contains "self[:news_enum] || ''"
                end
              end
            end
          end
        end
      }
    end
  end

  context 'multienum attribute' do
    before do
      Cms::Generators::Attribute::ApiGenerator.new do |attribute|
        attribute.name = 'news_multienum'
        attribute.type = :multienum
      end
    end

    it 'generates multienum attribute' do
      destination_root.should have_structure {
        directory 'app' do
          directory 'concerns' do
            directory 'cms' do
              directory 'attributes' do
                file 'news_multienum.rb' do
                  contains 'module Cms'
                  contains 'module Attributes'
                  contains 'module NewsMultienum'
                  contains 'def news_multienum'
                  contains "self[:news_multienum] || []"
                end
              end
            end
          end
        end
      }
    end
  end

  context 'html attribute' do
    before do
      Cms::Generators::Attribute::ApiGenerator.new do |attribute|
        attribute.name = 'news_html'
        attribute.type = :html
      end
    end

    it 'generates html attribute' do
      destination_root.should have_structure {
        directory 'app' do
          directory 'concerns' do
            directory 'cms' do
              directory 'attributes' do
                file 'news_html.rb' do
                  contains 'module Cms'
                  contains 'module Attributes'
                  contains 'module NewsHtml'
                  contains 'def news_html'
                  contains "(self[:news_html] || '').html_safe"
                end
              end
            end
          end
        end
      }
    end
  end

  context 'linklist attribute' do
    before do
      Cms::Generators::Attribute::ApiGenerator.new do |attribute|
        attribute.name = 'news_linklist'
        attribute.type = :linklist
      end
    end

    it 'generates linklist attribute' do
      destination_root.should have_structure {
        directory 'app' do
          directory 'concerns' do
            directory 'cms' do
              directory 'attributes' do
                file 'news_linklist.rb' do
                  contains 'module Cms'
                  contains 'module Attributes'
                  contains 'module NewsLinklist'
                  contains 'def news_linklist'
                  contains 'self[:news_linklist] || RailsConnector::LinkList.new(nil)'
                  contains 'def news_linklist?'
                  contains 'news_linklist.present?'
                end
              end
            end
          end
        end
      }
    end
  end

  context 'markdown attribute' do
    before do
      Cms::Generators::Attribute::ApiGenerator.new do |attribute|
        attribute.name = 'news_markdown'
        attribute.type = :markdown
      end
    end

    it 'generates markdown attribute' do
      destination_root.should have_structure {
        directory 'app' do
          directory 'concerns' do
            directory 'cms' do
              directory 'attributes' do
                file 'news_markdown.rb' do
                  contains 'module Cms'
                  contains 'module Attributes'
                  contains 'module NewsMarkdown'
                  contains 'def news_markdown'
                  contains "(self[:news_markdown] || '').html_safe"
                end
              end
            end
          end
        end
      }
    end
  end
end