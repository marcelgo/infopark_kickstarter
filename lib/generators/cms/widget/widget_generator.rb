module Cms
  module Generators
    class WidgetGenerator < ::Rails::Generators::NamedBase
      include Migration
      include Actions

      source_root File.expand_path('../templates', __FILE__)

      class_option :title,
        type: :string,
        desc: 'Widget title displayed in widget browser.'

      class_option :description,
        type: :string,
        desc: 'Widget description displayed in widget browser.'

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
        template('show.html.haml', "#{widget_path}/show.html.haml")
      end

      def create_thumbnail_view
        template('thumbnail.html.haml', "#{widget_path}/thumbnail.html.haml")
      end

      def create_edit_view
        # Not yet implemented
      end

      def create_locales
        template("en.locale.yml", "#{widget_path}/locales/en.#{file_name}.yml")
        template("de.locale.yml", "#{widget_path}/locales/de.#{file_name}.yml")
      end

      def create_assets
        # Not yet implemented
      end

      def create_widget
        begin
          Model::ApiGenerator.new(behavior: behavior) do |model|
            model.name = class_name
            model.title = title
            model.attributes = attributes
            model.preset_attributes = preset_attributes
            model.mandatory_attributes = mandatory_attributes
            model.migration_path = "#{widget_path}/migrate"
            model.model_path = model_path
          end

          turn_model_into_widget(class_name, model_path)
        rescue Cms::Generators::DuplicateResourceError
        end
      end

      private

      def title
        options[:title] || human_name
      end

      def description
        options[:description] || 'Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do
          eiusmod tempor incididunt ut labore et dolore magna aliqua.'
      end

      def attributes
        options[:attributes].inject([]) do |list, (name, type)|
          list << {name: name, type: type}
        end
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

      def model_path
        'app/models'
      end
    end
  end
end