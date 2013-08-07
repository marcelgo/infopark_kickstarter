module Cms
  module Generators
    module Widget
      class ColumnGenerator < ::Rails::Generators::Base
        include BasePaths
        include Example
        include Migration

        source_root File.expand_path('../templates', __FILE__)

        class_option :columns,
          type: :string,
          default: '2',
          desc: 'Number of columns'

        def create_widget
          begin
            Widget::ApiGenerator.new(behavior: behavior) do |widget|
              widget.name = obj_class_name
              widget.icon = '&#xF010;'
              widget.description = "The #{columns} column widget displays a box with #{columns} widget fields."
              widget.attributes = widget_attributes
            end

            template(
              'show.html.haml',
              "app/widgets/#{folder_name}/views/show.html.haml",
              force: true
            )
          rescue Cms::Generators::DuplicateResourceError
          end
        end

        def create_example
          example_migration_template(obj_class_name.underscore)
        end

        def notice
          if behavior == :invoke
            log(:migration, 'Make sure to run "rake cms:migrate" to apply CMS changes')
          end
        end

        private

        def widget_attributes
          (1..columns).inject([]) do |array, index|
            array << {
              name: column_name(index),
              type: :widget,
              title: column_title(index),
            }

            array
          end
        end

        def columns
          options[:columns].to_i
        end

        def obj_class_name
          "#{columns}ColumnWidget"
        end

        def folder_name
          obj_class_name.underscore
        end

        def column_title(column)
          "Column-#{column}"
        end

        def column_name(column)
          "column_#{column}".to_sym
        end
      end
    end
  end
end