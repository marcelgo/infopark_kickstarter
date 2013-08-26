module Cms
  module Generators
    module Widget
      class SlideshareGenerator < ::Rails::Generators::Base
        include Example
        include Migration

        source_root File.expand_path('../templates', __FILE__)

        def create_migration
          begin
            Widget::ApiGenerator.new(behavior: behavior) do |widget|
              widget.name = obj_class_name
              widget.icon = '&#xF01A;'
              widget.description = 'Creates a widget that shows a slide from slideshare.'
              widget.attributes = [
                {
                  name: 'source',
                  type: :linklist,
                  title: 'Source',
                  max_size: 1,
                }
              ]
            end

            directory('app', force: true)
            directory('spec')
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
          'SlideshareWidget'
        end
      end
    end
  end
end