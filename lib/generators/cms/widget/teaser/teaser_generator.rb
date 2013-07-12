module Cms
  module Generators
    module Widget
      class TeaserGenerator < ::Rails::Generators::Base
        source_root File.expand_path('../templates', __FILE__)

        def create_widget
          begin
            Widget::ApiGenerator.new(behavior: behavior) do |widget|
              widget.name = 'TeaserWidget'
              widget.icon = '&#xF010;'
              widget.description = 'Adds a teaser with a big headline and call-to-action button.'
              widget.attributes = [
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
                  name: 'link_to',
                  type: :linklist,
                  title: 'Link',
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