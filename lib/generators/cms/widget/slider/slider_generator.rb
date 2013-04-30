module Cms
  module Generators
    module Widget
      class SliderGenerator < ::Rails::Generators::Base
        source_root File.expand_path('../templates', __FILE__)

        def create_migration
          begin
            Widget::ApiGenerator.new(behavior: behavior) do |widget|
              widget.name = 'SliderWidget'
              widget.icon = '&#xF01A;'
              widget.description = 'Creates a rotating slider galerie from a list of images.'
              widget.attributes = [
                {
                  name: 'headline',
                  type: :string,
                  title: 'Headline',
                },
                {
                  name: 'images',
                  type: :linklist,
                  title: 'Images',
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