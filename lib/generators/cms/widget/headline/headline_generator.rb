module Cms
  module Generators
    module Widget
      class HeadlineGenerator < ::Rails::Generators::Base
        source_root File.expand_path('../templates', __FILE__)

        def create_widget
          begin
            Widget::ApiGenerator.new(behavior: behavior) do |widget|
              widget.name = 'HeadlineWidget'
              widget.icon = '&#xF010;'
              widget.description = 'Creates a simple widget with a headline.'
              widget.attributes = [
                {
                  name: 'headline',
                  type: :string,
                  title: 'Headline',
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