module Cms
  module Generators
    module Widget
      class ApiGenerator < ::Rails::Generators::NamedBase
        Rails::Generators.hide_namespace(self.namespace)

        include BasePaths

        source_root File.expand_path('../templates', __FILE__)

        attr_accessor :icon
        attr_accessor :title
        attr_accessor :description
        attr_accessor :attributes
        attr_accessor :preset_attributes
        attr_accessor :mandatory_attributes

        def initialize(config = {})
          yield self if block_given?

          super([name], {}, config)

          self.invoke_all
        end

        def create_model
          Model::ApiGenerator.new(behavior: behavior) do |model|
            model.name = name
            model.title = title
            model.migration_path = "#{widget_path}/migrate"
            model.attributes = attributes
            model.preset_attributes = preset_attributes
            model.mandatory_attributes = mandatory_attributes
          end
        end

        def create_show_view
          template('show.html.haml', "#{widget_path}/views/show.html.haml")
        end

        def create_edit_view
          EditView::ApiGenerator.new(behavior: behavior) do |model|
            model.path = "#{widget_path}/views"
            model.definitions = attributes
            model.object_variable = '@widget'
          end
        end

        def create_thumbnail
          Thumbnail::ApiGenerator.new(behavior: behavior) do |thumbnail|
            thumbnail.name = name
            thumbnail.path = "#{widget_path}/views"
            thumbnail.icon = icon
            thumbnail.title_key = "widgets.#{file_name}.title"
            thumbnail.description_key = "widgets.#{file_name}.description"
          end
        end

        def turn_model_into_widget
          path = "app/models/#{class_name.underscore}.rb"

          uncomment_lines(path, 'include Widget')
        end

        def add_locale
          Locale::ApiGenerator.new(behavior: behavior) do |locale|
            locale.name = name
            locale.path = "#{widget_path}/locales/en.#{file_name}.yml"
            locale.translations = {
              'en' => {
                'widgets' => {
                  file_name => {
                    'title' => title,
                    'description' => description,
                  },
                },
              },
            }
          end
        end

        private

        def icon
          @icon ||= 'puzzle'
        end

        def title
          @title ||= human_name
        end

        def description
          @description ||= ''
        end

        def attributes
          @attributes ||= []
        end

        def widget_path
          widget_path_for(file_name)
        end
      end
    end
  end
end
