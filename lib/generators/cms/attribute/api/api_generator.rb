module Cms
  module Generators
    module Attribute
      class ApiGenerator < ::Rails::Generators::NamedBase
        Rails::Generators.hide_namespace(self.namespace)
        include Migration

        source_root File.expand_path('../templates', __FILE__)

        attr_accessor :type
        attr_accessor :default
        attr_accessor :name

        def initialize(config = {})
          yield self if block_given?

          super([name], {}, config)

          self.invoke_all
        end

        def create_attribute_file
          template(
            "modules/#{type}_attribute.rb",
            "app/concerns/cms/attributes/#{file_name}.rb"
          )
        end

        private

        def type
          @type || :string
        end

        def default
          @default || case type.to_s
            when 'string', 'enum', 'html', 'markdown', 'text'
              ''
            when 'boolean'
              'Yes'
            when 'multienum'
              '[]'
            when 'linklist'
              'RailsConnector::LinkList.new(nil)'
            when 'integer'
              '0'
            when 'float'
              '0.0'
            else
              'nil'
          end
        end
      end
    end
  end
end