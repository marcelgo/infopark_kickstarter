module Cms
  module Generators
    module Widget
      module Maps
        class GoogleMapsGenerator < ::Rails::Generators::Base
          Rails::Generators.hide_namespace(self.namespace)

          include Actions

          source_root File.expand_path('../templates', __FILE__)

          def create_migration
            begin
              Model::ApiGenerator.new(behavior: behavior) do |model|
                model.name = obj_class_name
                model.title = 'Widget: GoogleMaps'
                model.migration_path = "#{widget_path}/migrate"
                model.model_path = model_path
                model.attributes = [
                  {
                    name: 'headline',
                    type: :string,
                    title: 'Headline',
                  },
                  {
                    name: 'content',
                    type: :html,
                    title: 'Content',
                  },
                  {
                    name: 'address',
                    type: :string,
                    title: 'Address',
                  },
                ]
              end

              turn_model_into_widget(obj_class_name, model_path)
            rescue Cms::Generators::DuplicateResourceError
            end
          end

          def copy_app_directory
            directory('app', force: true)

            template('thumbnail.html.haml', "#{widget_path}/views/thumbnail.html.haml")
          end

          def notice
            if behavior == :invoke
              log(:migration, 'Make sure to run "rake cms:migrate" to apply CMS changes')
            end
          end

          private

          def widget_path
            'app/widgets/google_maps_widget'
          end

          def model_path
            'app/models'
          end

          def obj_class_name
            'GoogleMapsWidget'
          end
        end
      end
    end
  end
end