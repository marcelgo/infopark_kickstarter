require 'spec_helper'

require 'generator_spec/test_case'
require 'generators/cms/edit_view/api/api_generator'

describe Cms::Generators::EditView::ApiGenerator do
  include GeneratorSpec::TestCase

  destination File.expand_path('../../../../tmp/generators', __FILE__)

  before do
    prepare_destination

    Cms::Generators::EditView::ApiGenerator.new do |config|
      config.path = 'app/views/foo'
      config.object_variable = '@obj'
      config.definitions = [
        {
          name: 'foo',
          type: :string,
          title: 'Foo',
        },
      ]
    end
  end

  it 'generates edit view' do
    destination_root.should have_structure {
      directory 'app' do
        directory 'views' do
          directory 'foo' do
            file 'edit.html.haml' do
              contains '= cms_edit_label(@obj, :foo)'
              contains '= cms_edit_string(@obj, :foo)'
            end
          end
        end
      end
    }
  end
end
