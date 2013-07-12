module Cms
  module Generators
    module Widget
      module Maps
        class GoogleMapsGenerator < ::Rails::Generators::Base
          include Example
          include Migration

          Rails::Generators.hide_namespace(self.namespace)

          source_root File.expand_path('../templates', __FILE__)

          def create_migration
            begin
              Widget::ApiGenerator.new(behavior: behavior) do |widget|
                widget.name = obj_class_name
                widget.icon = '&#xF008;'
                widget.description = 'Integrates a map that displays a pin for a given address.'
                widget.attributes = [
                  {
                    name: 'address',
                    type: :string,
                    title: 'Address',
                  },
                ]
              end

              directory('app', force: true)
            rescue Cms::Generators::DuplicateResourceError
            end
          end

          def create_example
            example_migration_template(obj_class_name.underscore)
          end

          def notice
            if behavior == :invoke
              log(:migration, 'Make sure to run "rake cms:migrate" to apply CMS changes')
            end
          end

          private

          def obj_class_name
            'GoogleMapsWidget'
          end
        end
      end
    end
  end
end