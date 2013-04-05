module Cms
  module Generators
    module Widget
      class PersonGenerator < ::Rails::Generators::Base
        include Migration
        include BasePaths
        include Actions

        class_option :example,
          type: :boolean,
          default: false,
          desc: 'Generate an example migration?'

        source_root File.expand_path('../templates', __FILE__)

        def create_migration
          begin
            validate_attribute(sort_key_attribute_name)
            Rails::Generators.invoke('cms:attribute', [sort_key_attribute_name, '--type=string', '--title=Sort Key'])
          rescue DuplicateResourceError
          end

          begin
            validate_attribute(person_attribute_name)
            Rails::Generators.invoke('cms:attribute', [person_attribute_name, '--type=string', '--title=Person Identifier'])
          rescue DuplicateResourceError
          end

          begin
            validate_obj_class(obj_class_name)
            Rails::Generators.invoke('cms:model', [obj_class_name, '--title=Widget: Person', "--attributes=#{person_attribute_name}", sort_key_attribute_name])
            turn_model_into_widget(obj_class_name)
          rescue DuplicateResourceError
          end
        end

        def copy_app_directory
          directory('app', force: true)

          template('thumbnail.html.haml', 'app/widgets/person_widget/thumbnail.html.haml')
        end

        def add_example
          if example?
            migration_template('example_migration.rb', 'cms/migrate/create_person_widget_example.rb')
          end
        end

        def notice
          if behavior == :invoke
            log(:migration, 'Make sure to run "rake cms:migrate" to apply CMS changes')
          end
        end

        private

        def example?
          options[:example]
        end

        def human_name
          'Person Widget'
        end

        def obj_class_name
          'PersonWidget'
        end

        def sort_key_attribute_name
          'sort_key'
        end

        def person_attribute_name
          'person'
        end
      end
    end
  end
end