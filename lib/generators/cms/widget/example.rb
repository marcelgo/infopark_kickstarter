module Cms
  module Generators
    module Widget
      module Example
        include BasePaths
        include BaseAttributes

        def self.included(base)
          base.class_option :example,
            type: :boolean,
            default: false,
            desc: 'Create an example'

          base.class_option :obj_path,
            type: :string,
            desc: 'Path to the obj that holds the widget'

          base.class_option :attribute,
            type: :string,
            desc: 'Widget attribute of the obj that holds the widget'
        end

        private

        def example_obj_path
          options[:obj_path] || homepage_path
        end

        def example_obj_widget_attribute
          options[:attribute] || homepage_widget_attribute
        end

        def example?
          options[:example]
        end

        def example_obj_path?
          example_obj_path
        end

        def example_obj_widget_attribute?
          example_obj_widget_attribute
        end

        def example_migration_template(migration_name)
          if example?
            migration_template(
              'example_migration.rb',
              "cms/migrate/create_#{migration_name}_example.rb"
            )
          end
        end
      end
    end
  end
end