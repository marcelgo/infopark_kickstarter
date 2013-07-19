require 'spec_helper'

require 'generator_spec/test_case'
require 'rails/generators/test_case'
require 'generators/cms/widget/login/login_generator.rb'

describe Cms::Generators::Widget::LoginGenerator do
  include GeneratorSpec::TestCase

  destination File.expand_path('../../../../tmp/generators', __FILE__)
  arguments ['--example']

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
          directory 'login_widget' do
            directory 'views' do
              file 'show.html.haml'
              file 'thumbnail.html.haml'
              file '_form.html.haml'
              file '_login.html.haml'
              file '_logout.html.haml'
              file '_reset_password.html.haml'
            end

            directory 'locales' do
              file 'en.login_widget.yml'
            end

            directory 'migrate' do
              migration 'create_login_widget'
              migration 'create_login_widget_example'
            end
          end
        end

        directory 'models' do
          file 'login_widget.rb' do
            contains 'include Widget'
          end
        end
      end
    }
  end
end