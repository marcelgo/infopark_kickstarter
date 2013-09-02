require 'spec_helper'

require 'generator_spec/test_case'
require 'generators/cms/component/developer_tools/developer_tools_generator'

describe Cms::Generators::Component::DeveloperToolsGenerator do
  include GeneratorSpec::TestCase

  destination File.expand_path('../../../../tmp/generators', __FILE__)

  before do
    prepare_destination
    prepare_environments
    run_generator
  end

  def prepare_environments
    config_path = "#{destination_root}/config"

    mkdir_p(config_path)

    File.open("#{config_path}/routes.rb", 'w') { |file| file.write('Dummy::Application.routes.draw do') }
    File.open("#{destination_root}/Gemfile", 'w')
  end

  it 'adds developer tools' do
    destination_root.should have_structure {
      file 'Gemfile' do
        contains 'gem "pry-rails"'
        contains 'gem "rails-footnotes"'
        contains 'gem "thin"'
        contains 'gem "infopark_dashboard"'

        contains 'gem "better_errors"'
        contains 'gem "binding_of_caller"'
      end

      directory 'config' do
        directory 'initializers' do
          file 'rails_footnotes.rb'
        end

        file 'routes.rb' do
          contains 'mount InfoparkDashboard::Engine => "/cms/dashboard"'
        end
      end

      directory 'lib' do
        directory 'footnotes' do
          directory 'notes' do
            file 'help_note.rb'
            file 'dashboard_note.rb'
            file 'dev_center_note.rb'
            file 'obj_class_note.rb'
          end
        end
      end
    }
  end
end
