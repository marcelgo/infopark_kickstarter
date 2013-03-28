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

        def initialize(config = {})
          yield self if block_given?

          super([name], {}, config)

          self.invoke_all
        end

        def process_types
          attributes.each do |definition|
            case definition[:type].to_s
              when 'boolean'
                definition[:type] = :enum
                definition[:values] = ['Yes', 'No']
              when 'integer', 'float'
                definition[:type] = :string
            end
          end
        end

        def process_defaults
          preset_attributes.each do |name, default|
            if default.present?

            end
          end
        end

        def validate_model
          validate_obj_class(class_name)
        end

        def create_model_file
          template('model.rb', File.join('app/models', "#{file_name}.rb"))
        end

        def create_migration_file
          validate_obj_class(class_name)
          migration_template('migration.rb', "cms/migrate/create_#{file_name}.rb")
        rescue DuplicateResourceError
        end

        def create_spec_file
          template('spec.rb', File.join('spec/models', "#{file_name}_spec.rb"))
        end

        def create_attribute_concerns
          attributes.each do |definition|
            name = definition[:name]
            type = definition[:type]

            Attribute::ApiGenerator.new(behavior: behavior) do |attribute|
              attribute.name = name
              attribute.type = type

              if preset_attributes[name].present?
                attribute.default = preset_attributes[name]
              end
            end
          end
        end

        private

        def type
          @type || :publication
        end

        def title
          @title || human_name
        end

        def attributes
          @attributes || []
        end

        def preset_attributes
          @preset_attributes || {}
        end

        def mandatory_attributes
          @mandatory_attributes || []
        end
      end
    end
  end
end