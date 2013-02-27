require 'spec_helper'

require 'generator_spec/test_case'
require 'generators/cms/attribute/attribute_generator'

describe Cms::Generators::AttributeGenerator do
  include GeneratorSpec::TestCase

  destination File.expand_path('../../../tmp', __FILE__)
  arguments ['news', '--type=string']

  before do
    prepare_destination
    run_generator
  end

  it 'generates string attribute migration' do
    destination_root.should have_structure {
      directory 'cms' do
        directory 'migrate' do
          migration 'create_news_attribute' do
            contains "create_attribute(name: 'news', type: 'string', title: '')"
          end
        end
      end

      directory 'app' do
        directory 'concerns' do
          directory 'cms' do
            directory 'attributes' do
              file 'news.rb' do
                contains 'module Cms'
                contains 'module Attributes'
                contains 'module News'
                contains 'def news'
                contains "self[:news].to_s"
              end
            end
          end
        end
      end
    }
  end
end

describe Cms::Generators::AttributeGenerator do
  include GeneratorSpec::TestCase

  destination File.expand_path('../../../tmp', __FILE__)
  arguments ['news_link', '--type=linklist', '--max-size=1', '--min-size=1']

  before do
    prepare_destination
    run_generator
  end

  it 'generates linklist attribute migration' do
    destination_root.should have_structure {
      directory 'cms' do
        directory 'migrate' do
          migration 'create_news_link_attribute' do
            contains 'class CreateNewsLinkAttribute < ::RailsConnector::Migration'
            contains 'create_attribute('
            contains "name: 'news_link',"
            contains "type: 'linklist',"
            contains "title: '',"
            contains "max_size: 1,"
            contains "min_size: 1"
          end
        end
      end

      directory 'app' do
        directory 'concerns' do
          directory 'cms' do
            directory 'attributes' do
              file 'news_link.rb' do
                contains 'module Cms'
                contains 'module Attributes'
                contains 'module News'
                contains 'def news_link'
                contains 'self[:news_link] || RailsConnector::LinkList.new(nil)'
                contains 'def news_link?'
                contains 'news_link.present?'
                contains 'def first_news_link'
                contains 'news_link.destination_objects.first'
              end
            end
          end
        end
      end
    }
  end
end

describe Cms::Generators::AttributeGenerator do
  include GeneratorSpec::TestCase

  destination File.expand_path('../../../tmp', __FILE__)
  arguments ['news', '--type=enum', '--values=Yes', 'No', 'Something']

  before do
    prepare_destination
    run_generator
  end

  it 'generates enum attribute migration' do
    destination_root.should have_structure {
      directory 'cms' do
        directory 'migrate' do
          migration 'create_news_attribute' do
            contains 'class CreateNewsAttribute < ::RailsConnector::Migration'
            contains 'create_attribute('
            contains "name: 'news',"
            contains "type: 'enum',"
            contains "title: '',"
            contains 'values: ["Yes", "No", "Something"]'
          end
        end
      end
    }
  end
end

describe Cms::Generators::AttributeGenerator do
  include GeneratorSpec::TestCase

  destination File.expand_path('../../../tmp', __FILE__)
  arguments ['news', '--type=boolean']

  before do
    prepare_destination
    run_generator
  end

  it 'generates boolean (enum) attribute migration' do
    destination_root.should have_structure {
      directory 'cms' do
        directory 'migrate' do
          migration 'create_news_attribute' do
            contains 'class CreateNewsAttribute < ::RailsConnector::Migration'
            contains 'create_attribute('
            contains "name: 'news',"
            contains "type: 'enum',"
            contains "title: '',"
            contains 'values: ["Yes", "No"]'
          end
        end
      end
    }
  end
end

describe Cms::Generators::AttributeGenerator do
  include GeneratorSpec::TestCase

  destination File.expand_path('../../../tmp', __FILE__)
  arguments ['news', '--type=multienum', '--values=Yes', 'No']

  before do
    prepare_destination
    run_generator
  end

  it 'generates multienum attribute migration' do
    destination_root.should have_structure {
      directory 'cms' do
        directory 'migrate' do
          migration 'create_news_attribute' do
            contains 'class CreateNewsAttribute < ::RailsConnector::Migration'
            contains 'create_attribute('
            contains "name: 'news',"
            contains "type: 'multienum',"
            contains "title: '',"
            contains 'values: ["Yes", "No"]'
          end
        end
      end
    }
  end
end