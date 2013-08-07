module Cms
  module Generators
    module Actions
      def generate_attribute_method(attribute)
        method = "cms_attribute :#{attribute[:name]}, type: :#{attribute[:type]}"

        if attribute[:default].present?
          method.concat(", default: '#{attribute[:default]}'")
        end

        if attribute[:values].present?
          method.concat(", values: #{attribute[:values].inspect}")
        end

        if attribute[:max_size].present?
          method.concat(", max_size: #{attribute[:max_size]}")
        end

        if attribute[:min_size].present?
          method.concat(", min_size: #{attribute[:min_size]}")
        end

        method
      end

      def generate_edit_field(attribute)
        name = attribute[:name]
        type = attribute[:type]

        "= cms_edit_#{type}(@widget, :#{name})"
      end

      def generate_label(attribute)
        name = attribute[:name]

        "= cms_edit_label(@widget, :#{name})"
      end

      def add_model_attribute(model, attribute, model_path = 'app/models')
        file = "#{model_path}/#{model.underscore}.rb"
        insert_point = "class #{model} < Obj\n"

        data = []

        data << "  #{generate_attribute_method(attribute)}"
        data << ''

        data = data.join("\n")

        insert_into_file(file, data, :after => insert_point)
      end
    end
  end
end