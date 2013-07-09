module Cms
  module Generators
    module Widget
      class ImageGenerator < ::Rails::Generators::Base
        source_root File.expand_path('../templates', __FILE__)

        def create_widget
          begin
            Widget::ApiGenerator.new(behavior: behavior) do |widget|
              widget.name = 'ImageWidget'
              widget.icon = '&#xF061;'
              widget.description = 'Widget that holds an image.'
              widget.attributes = [
                {
                  name: 'source',
                  type: :linklist,
                  title: 'Source',
                  max_size: 1,
                },
              ]
            end

            directory('app', force: true)
          rescue Cms::Generators::DuplicateResourceError
          end
        end

        def notice
          if behavior == :invoke
            log(:migration, 'Make sure to run "rake cms:migrate" to apply CMS changes')
          end
        end
      end
    end
  end
end