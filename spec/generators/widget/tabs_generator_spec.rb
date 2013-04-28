require 'spec_helper'

require 'generator_spec/test_case'
require 'rails/generators/test_case'
require 'generators/cms/widget/tabs/tabs_generator.rb'

describe Cms::Generators::Widget::TabsGenerator do
  include GeneratorSpec::TestCase

  destination File.expand_path('../../../../tmp/generators', __FILE__)

  before do
    prepare_destination
    prepare_environments
    run_generator
  end

  def prepare_environments
  end

  it 'creates files' do
    destination_root.should have_structure {
      directory 'app' do
        directory 'cells' do
          directory 'widget' do
            file 'tabs_widget_cell.rb'

            directory 'tabs_widget' do
              file 'show.html.haml'
            end
          end
        end

        directory 'models' do
          file 'tabs_widget.rb' do
            contains 'include Widget'
          end
          file 'tab.rb' do
            contains 'cms_attribute :headline, type: :string'
            contains 'cms_attribute :content, type: :html'
          end
        end

        directory 'widgets' do
          directory 'tabs_widget' do
            directory 'migrate' do
              migration 'create_tabs_widget'
            end

            directory 'views' do
              file 'show.html.haml' do
                contains '= render_cell(:widget, :show, @obj, @widget)'
              end
            end
          end
        end
      end

      directory 'cms' do
        directory 'migrate' do
          migration 'create_tab'
        end
      end
    }
  end
end