require 'spec_helper'

require 'generator_spec/test_case'
require 'rails/generators/test_case'
require 'generators/cms/widget/hero_unit/hero_unit_generator.rb'

describe Cms::Generators::Widget::HeroUnitGenerator do
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
        directory 'widgets' do
          directory 'hero_unit_widget' do
            directory 'views' do
              file 'show.html.haml'
              file 'thumbnail.html.haml'
            end

            directory 'locales' do
              file 'en.hero_unit_widget.yml'
            end

            directory 'migrate' do
              migration 'create_hero_unit_widget'
            end
          end
        end

        directory 'models' do
          file 'hero_unit_widget.rb' do
            contains 'cms_attribute :content, type: :html'
            contains 'cms_attribute :headline, type: :string'
            contains 'cms_attribute :link, type: :linklist, max_size: 1'
            contains 'include Widget'
          end
        end
      end
    }
  end
end