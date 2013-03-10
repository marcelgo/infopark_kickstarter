module Cms
  module Generators
    class AttributeGenerator < ::Rails::Generators::NamedBase
      include Migration

      source_root File.expand_path('../templates', __FILE__)

      class_option :type,
        type: :string,
        aliases: '-t',
        default: 'string',
        desc: 'Type of the CMS attribute (string | text | html | markdown | enum | boolean | multienum | linklist | date | integer | float).'

      class_option :values,
        type: :array,
        aliases: '-v',
        default: [],
        desc: 'Possible values for attributes of type (enum | multienum).'

      class_option :title,
        type: :string,
        default: '',
        desc: 'Title of the CMS attribute.'

      class_option :min_size,
        type: :numeric,
        default: 0,
        desc: 'Minimum number of links in a linklist.'

      class_option :max_size,
        type: :numeric,
        default: 0,
        desc: 'Maximum number of links in a linklist.'

      class_option :method_name,
        type: :string,
        default: nil,
        desc: 'Method name to access the CMS attribute. Defaults to the name of the attribute.'

      def create_migration_file
        validate_attribute(file_name)

        migration_template("migrations/#{type}_migration.rb", "cms/migrate/create_#{file_name}_attribute.rb")
      rescue DuplicateResourceError
      end

      def create_attribute_file
        template("modules/#{type}_attribute.rb", "app/concerns/cms/attributes/#{file_name}.rb")
      end

      private

      def min_size
        options[:min_size]
      end

      def max_size
        options[:max_size]
      end

      def title
        options[:title] || human_name
      end

      def type
        options[:type]
      end

      def values
        options[:values].inspect
      end

      def method_name
        options[:method_name] || file_name
      end
    end
  end
end