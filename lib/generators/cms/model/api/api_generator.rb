module Cms
  module Generators
    module Model
      class ApiGenerator < ::Rails::Generators::NamedBase
        Rails::Generators.hide_namespace(self.namespace)
        include Migration

        source_root File.expand_path('../templates', __FILE__)

        attr_accessor :name
        attr_accessor :title
        attr_accessor :type
        attr_accessor :attributes
        attr_accessor :preset_attributes
        attr_accessor :mandatory_attributes
        attr_accessor :migration_path
        attr_accessor :model_path

        def initialize(config = {})
          yield self if block_given?

          super([name], {}, config)

          self.invoke_all
        end

        def handle_attributes
          attributes.each do |definition|
            name = definition[:name]
            type = definition[:type]
            default = definition.delete(:default)

            if default.present?
              preset_attributes[name] = default
            end

            Attribute::ApiGenerator.new(behavior: behavior) do |attribute|
              attribute.name = name
              attribute.type = type

              if preset_attributes[name].present?
                attribute.default = preset_attributes[name]
              end
            end

            case type.to_s
              when 'boolean'
                definition[:type] = :enum
                definition[:values] = ['Yes', 'No']
              when 'integer', 'float'
                definition[:type] = :string
            end
          end
        end

        def validate_model
          validate_obj_class(class_name)
        end

        def create_model_file
          template('model.rb', File.join(model_path, "#{file_name}.rb"))
        end

        def create_migration_file
          validate_obj_class(class_name)
          migration_template('migration.rb', "#{migration_path}/create_#{file_name}.rb")
        rescue DuplicateResourceError
        end

        private

        def type
          @type ||= :publication
        end

        def title
          @title ||= human_name
        end

        def attributes
          @attributes ||= []
        end

        def preset_attributes
          @preset_attributes ||= {}
        end

        def mandatory_attributes
          @mandatory_attributes ||= []
        end

        def migration_path
          @migration_path ||= 'cms/migrate'
        end

        def model_path
          @model_path ||= 'app/models'
        end
      end
    end
  end
end