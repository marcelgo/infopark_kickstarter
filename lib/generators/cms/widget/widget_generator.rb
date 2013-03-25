module Cms
  module Generators
    class WidgetGenerator < ::Rails::Generators::NamedBase
      include Migration

      source_root File.expand_path('../templates', __FILE__)

      class_option :title,
        type: :string,
        desc: 'Display title.'

      class_option :attributes,
        type: :hash,
        aliases: '-a',
        default: {},
        desc: 'Description of attributes and their type.'

      class_option :preset_attributes,
        type: :hash,
        aliases: '-p',
        default: {},
        desc: 'Description of attributes and their defaults.'

      class_option :mandatory_attributes,
        type: :array,
        aliases: '-m',
        default: [],
        desc: 'List of mandatory attributes.'

      def create_show_view
        template('show.html.erb', "#{widget_path}/show.html.erb")
      end

      def create_thumbnail_view
        template('thumbnail.html.erb', "#{widget_path}/thumbnail.html.erb")
      end

      def create_edit_view
        # Not yet implemented
      end

      def create_locales
        # Not yet implemented
      end

      def create_assets
        # Not yet implemented
      end

      def create_migration
        migration_template('migration.rb', "cms/migrate/create_#{file_name}.rb")
      end

      private

      def title
        options[:title] || human_name
      end

      def attributes
        options[:attributes]
      end

      def preset_attributes
        options[:preset_attributes]
      end

      def mandatory_attributes
        options[:mandatory_attributes]
      end

      def widget_path
        "app/widgets/#{file_name}"
      end
    end
  end
end