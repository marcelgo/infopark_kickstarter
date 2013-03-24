module Cms
  module Generators
    class ModelGenerator < ::Rails::Generators::NamedBase
      include Migration

      source_root File.expand_path('../templates', __FILE__)

      class_option :title,
        type: :string,
        desc: 'Title of the CMS object class.'

      class_option :type,
        type: :string,
        aliases: '-t',
        default: 'publication',
        desc: 'Type of the CMS object class.'

      class_option :attributes,
        type: :array,
        aliases: '-a',
        default: [],
        desc: 'List of CMS attributes of the new CMS object class.'

      class_option :preset_attributes,
        type: :hash,
        aliases: '-p',
        default: {},
        desc: 'Hash of CMS attributes and their presets for the new object class.'

      class_option :mandatory_attributes,
        type: :array,
        aliases: '-m',
        default: [],
        desc: 'List of CMS mandatory attributes of the new object class.'

      def create_model_file
        template('model.rb', File.join('app/models', "#{file_name}.rb"))
      end

      def create_migration_file
        validate_obj_class(class_name)

        migration_template('migration.rb', "cms/migrate/create_#{file_name}.rb")
      rescue DuplicateResourceError
      end

      def create_spec_files
        template('spec.rb', File.join('spec/models', "#{file_name}_spec.rb"))
      end

      private

      def attributes
        options[:attributes]
      end

      def title
        options[:title] || human_name
      end

      def type
        options[:type]
      end

      def preset_attributes
        options[:preset_attributes]
      end

      def mandatory_attributes
        options[:mandatory_attributes]
      end
    end
  end
end