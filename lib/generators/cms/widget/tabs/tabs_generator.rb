module Cms
  module Generators
    module Widget
      class TabsGenerator < ::Rails::Generators::Base
        include Actions

        source_root File.expand_path('../templates', __FILE__)

        def create_migration
          begin
            Widget::ApiGenerator.new(behavior: behavior) do |widget|
              widget.name = 'TabsWidget'
              widget.icon = '&#xF00F;'
              widget.description = 'Creates a tabs widget that displays content for each defined tab.'
            end

            Model::ApiGenerator.new(behavior: behavior) do |model|
              model.name = 'Tab'
              model.title = 'Page: Tab'
              model.description = 'Creates a single tab content that can be used in the tabs widget.'
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
              ]
            end

            turn_model_into_page('Tab')

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