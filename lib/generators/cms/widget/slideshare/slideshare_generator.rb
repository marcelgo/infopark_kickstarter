module Cms
  module Generators
    module Widget
      class SlideshareGenerator < ::Rails::Generators::Base
        source_root File.expand_path('../templates', __FILE__)

        def create_migration
          begin
            Widget::ApiGenerator.new(behavior: behavior) do |widget|
              widget.name = 'SlideshareWidget'
              widget.icon = '&#xF01A;'
              widget.description = 'Creates a widget that shows a slide from slideshare.'
              widget.attributes = [
                {
                  name: 'headline',
                  type: :string,
                  title: 'Headline',
                },
                {
                  name: 'content',
                  type: :html,
                  title: 'content',
                },
                {
                  :name=>"source",
                  type: :linklist,
                  :title => "Source",
                  max_size: 1
                }
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