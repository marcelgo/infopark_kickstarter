require 'spec_helper'

require 'generator_spec/test_case'
require 'generators/cms/component/language_switch/language_switch_generator.rb'

describe Cms::Generators::Component::LanguageSwitchGenerator do
  include GeneratorSpec::TestCase

  destination File.expand_path('../../../../tmp', __FILE__)
  arguments []

  before do
    prepare_destination
    prepare_environments
    run_generator
  end

  def prepare_environments
    layouts_path = "#{destination_root}/app/views/layouts"

    mkdir_p(layouts_path)

    File.open("#{layouts_path}/application.html.haml", 'w') { |f| f.write("            = render_cell(:meta_navigation, :show, @obj, current_user)\n") }
  end

  it 'creates views' do
    destination_root.should have_structure {
      directory 'app' do
        directory 'cells' do
          file 'language_switch_cell.rb'

          directory 'language_switch' do
            file 'show.html.haml'
            file 'entry.html.haml'
          end
        end

        directory 'views' do
          directory 'layouts' do
            file 'application.html.haml' do
              contains '= render_cell(:language_switch, :show, @obj.website.homepages, @obj.homepage)'
            end
          end
        end
      end

      directory 'config' do
        directory 'locales' do
          file 'de.language_switch.yml'
          file 'en.language_switch.yml'
        end
      end
    }
  end
end