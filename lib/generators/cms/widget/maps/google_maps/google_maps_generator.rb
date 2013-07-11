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
                widget.name = obj_class
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
            if example?
              migration_template(
                'example_migration.rb',
                'cms/migrate/create_google_maps_widget_example.rb'
              )
            end
          end

          def notice
            if behavior == :invoke
              log(:migration, 'Make sure to run "rake cms:migrate" to apply CMS changes')
            end
          end

          private

          def obj_class
            'GoogleMapsWidget'
          end
        end
      end
    end
  end
end