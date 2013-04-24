module Cms
  module Generators
    module Widget
      class TextGenerator < ::Rails::Generators::Base
        include Actions

        source_root File.expand_path('../templates', __FILE__)

        def create_migration
          begin
            Model::ApiGenerator.new(behavior: behavior) do |model|
              model.name = obj_class_name
              model.title = 'Widget: Text'
              model.migration_path = "#{widget_path}/migrate"
              model.model_path = model_path
            end

            turn_model_into_widget(obj_class_name, model_path)
          rescue Cms::Generators::DuplicateResourceError
          end
        end

        def create_widget
          directory('app')

          template('thumbnail.html.haml', "#{widget_path}/views/thumbnail.html.haml")
        end

        def notice
          if behavior == :invoke
            log(:migration, 'Make sure to run "rake cms:migrate" to apply CMS changes')
          end
        end

        private

        def widget_path
          'app/widgets/text_widget'
        end

        def model_path
          'app/models'
        end

        def obj_class_name
          'TextWidget'
        end
      end
    end
  end
end