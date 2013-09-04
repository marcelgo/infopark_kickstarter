module Cms
  module Generators
    module Widget
      class LoginGenerator < ::Rails::Generators::Base
        include Migration
        include Example

        source_root File.expand_path('../templates', __FILE__)

        def create_widget
          begin
            Widget::ApiGenerator.new(behavior: behavior) do |widget|
              widget.name = obj_class_name
              widget.icon = 'login'
              widget.description = 'Displays a login form.'
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
          'LoginWidget'
        end
      end
    end
  end
end