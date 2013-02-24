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
        desc: 'List of CMS attributes of the CMS object class.'

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
    end
  end
end