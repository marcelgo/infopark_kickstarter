module Cms
  module Generators
    module Actions
      def turn_model_into_page(class_name)
        file_name = "#{class_name.underscore}.rb"

        gsub_file(
          "app/models/#{file_name}",
          '# include Page',
          'include Page'
        )
      end

      def turn_model_into_widget(class_name)
        file_name = "#{class_name.underscore}.rb"

        gsub_file(
          "app/models/#{file_name}",
          '# include Widget',
          'include Widget'
        )
      end

      def add_model_attribute(model, attribute)
        file = "app/models/#{model.underscore}.rb"
        insert_point = "class #{model} < Obj\n"

        data = []

        data << "  include Cms::Attributes::#{attribute.camelize}"
        data << ''

        data = data.join("\n")

        insert_into_file(file, data, :after => insert_point)
      end
    end
  end
end