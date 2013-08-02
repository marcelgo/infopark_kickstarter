require 'spec_helper'

require 'generator_spec/test_case'
require 'generators/cms/widget/column/column_generator.rb'

describe Cms::Generators::Widget::ColumnGenerator do
  include GeneratorSpec::TestCase

  destination File.expand_path('../../../../tmp/generators', __FILE__)
  arguments ['--columns=3']

  before do
    prepare_destination
    run_generator
  end

  it 'creates files' do
    destination_root.should have_structure {
      directory 'app' do
        directory 'widgets' do
          directory '3_column_widget' do
            directory 'locales' do
              file 'en.3_column_widget.yml'
            end

            directory 'migrate' do
              migration 'create_3_column_widget'
            end

            directory 'views' do
              file 'show.html.haml'
              file 'thumbnail.html.haml'
            end
          end
        end

        directory 'models' do
          file '3_column_widget.rb' do
            contains 'cms_attribute :column_1, type: :widget'
            contains 'cms_attribute :column_2, type: :widget'
            contains 'cms_attribute :column_3, type: :widget'
            contains 'include Widget'
          end
        end
      end
    }
  end
end