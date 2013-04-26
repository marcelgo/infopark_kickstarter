require 'spec_helper'

require 'generator_spec/test_case'
require 'generators/cms/component/form_builder/form_builder_generator.rb'
require 'generators/cms/attribute/api/api_generator'
require 'generators/cms/model/api/api_generator'

describe Cms::Generators::Component::FormBuilderGenerator do
  include GeneratorSpec::TestCase

  destination File.expand_path('../../../../tmp/generators', __FILE__)

  arguments ['--cms_path=/website/en']

  before(:all) do
    Cms::Generators::Attribute::ApiGenerator.send(:include, TestDestinationRoot)
    Cms::Generators::Model::ApiGenerator.send(:include, TestDestinationRoot)
  end

  before do
    prepare_destination
    run_generator
  end

  it 'creates file' do
    destination_root.should have_structure do
      directory 'app' do
        directory 'models' do
          file 'form_builder.rb'
        end

        directory 'cells' do
          file 'form_builder_cell.rb'

          directory 'form_builder' do
            file 'show.html.haml'
            file 'input.html.haml'
          end
        end

        directory 'presenters' do
          file 'form_presenter.rb'
        end

        directory 'services' do
          file 'activity_service.rb'
        end

        directory 'concerns' do
          directory 'cms' do
            directory 'attributes' do
              file 'headline.rb'
              file 'content.rb'
              file 'sort_key.rb'
              file 'show_in_navigation.rb'
              file 'crm_activity_type.rb'
            end
          end
        end
      end

      directory 'config' do
        directory 'locales' do
          file 'en.form_builder.yml'
          file 'de.form_builder.yml'
        end
      end

      directory 'cms' do
        directory 'migrate' do
          migration 'create_form_builder'
          migration 'create_form_builder_example'
        end
      end
    end
  end
end