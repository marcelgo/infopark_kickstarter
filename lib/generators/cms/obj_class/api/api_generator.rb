module Cms
  module Generators
    module ObjClass
      class ApiGenerator < ::Rails::Generators::NamedBase
        Rails::Generators.hide_namespace(self.namespace)

        source_root File.expand_path('../templates', __FILE__)

        attr_accessor :title
        attr_accessor :description
        attr_accessor :type
        attr_accessor :thumbnail
        attr_accessor :attributes
        attr_accessor :preset_attributes
        attr_accessor :mandatory_attributes
        attr_accessor :page

        def initialize(config = {})
          yield self if block_given?

          super([name], {}, config)

          self.invoke_all
        end

        def create_model
          Model::ApiGenerator.new(behavior: behavior) do |model|
            model.name = name
            model.type = type
            model.title = title
            model.description = description
            model.thumbnail = thumbnail
            model.attributes = attributes
            model.preset_attributes = preset_attributes
            model.mandatory_attributes = mandatory_attributes
            model.page = page
          end
        end

        def create_edit_view
          EditView::ApiGenerator.new(behavior: behavior) do |model|
            model.path = "app/views/#{class_name.underscore}"
            model.definitions = attributes
            model.object_variable = '@obj'
          end
        end

        private

        def attributes
          @attributes ||= []
        end
      end
    end
  end
end
