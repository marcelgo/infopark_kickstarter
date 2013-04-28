module Cms
  module Generators
    module Widget
      class PersonGenerator < ::Rails::Generators::Base
        source_root File.expand_path('../templates', __FILE__)

        def create_migration
          begin
            Widget::ApiGenerator.new(behavior: behavior) do |widget|
              widget.name = 'PersonWidget'
              widget.icon = '&#xF00A;'
              widget.description = 'Displays a WebCRM person and shows their details.'
              widget.attributes = [
                {
                  name: 'person',
                  type: :string,
                  title: 'Person identifier',
                },
              ]
            end

            directory('app', force: true)
          rescue Cms::Generators::DuplicateResourceError
          end
        end

        def notice
          if behavior == :invoke
            log(:migration, 'Make sure to run "rake cms:migrate" to apply CMS changes.')
          end
        end
      end
    end
  end
end