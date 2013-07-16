module Cms
  module Generators
    module Widget
      class TextGenerator < ::Rails::Generators::Base
        include Example
        include Migration

        source_root File.expand_path('../templates', __FILE__)

        def create_widget
          begin
            Widget::ApiGenerator.new(behavior: behavior) do |widget|
              widget.name = obj_class_name
              widget.icon = '&#xF058;'
              widget.description = 'Creates a simple widget with content.'
              widget.attributes = [
                {
                  name: 'content',
                  type: :html,
                  title: 'Content',
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
          'TextWidget'
        end
      end
    end
  end
end