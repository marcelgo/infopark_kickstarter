module Cms
  module Generators
    module Widget
      class PersonGenerator < ::Rails::Generators::Base
        include Actions

        source_root File.expand_path('../templates', __FILE__)

        def create_migration
          begin
            Model::ApiGenerator.new(behavior: behavior) do |model|
              model.name = obj_class_name
              model.title = 'Widget: Person'
              model.attributes = [
                {
                  name: sort_key_attribute_name,
                  type: :string,
                  title: 'Sort key',
                },
                {
                  name: person_attribute_name,
                  type: :string,
                  title: 'Person identifier',
                },
              ]
            end

            turn_model_into_widget(obj_class_name)
          rescue Cms::Generators::DuplicateResourceError
          end
        end

        def copy_app_directory
          directory('app', force: true)

          template('thumbnail.html.haml', 'app/widgets/person_widget/thumbnail.html.haml')
        end

        def notice
          if behavior == :invoke
            log(:migration, 'Make sure to run "rake cms:migrate" to apply CMS changes')
          end
        end

        private

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