module Cms
  module Generators
    class ModelGenerator < ::Rails::Generators::NamedBase
      include Migration

      source_root File.expand_path('../templates', __FILE__)

      class_option :title,
        type: :string,
        desc: 'Model title'

      class_option :type,
        type: :string,
        aliases: '-t',
        default: 'publication',
        desc: 'Type (publication | generic | document)'

      class_option :attributes,
        type: :hash,
        aliases: '-a',
        default: {},
        desc: 'Attributes and their types'

      class_option :preset_attributes,
        type: :hash,
        aliases: '-p',
        default: {},
        desc: 'Attributes and their defaults'

      class_option :mandatory_attributes,
        type: :array,
        aliases: '-m',
        default: [],
        desc: 'List of mandatory attributes'

      def create
        Model::ApiGenerator.new(behavior: behavior) do |model|
          model.name = name
          model.title = title
          model.type = type
          model.attributes = attributes
          model.preset_attributes = preset_attributes
          model.mandatory_attributes = mandatory_attributes
        end
      end

      private

      def type
        options[:type]
      end

      def title
        options[:title] || human_name
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
    end
  end
end