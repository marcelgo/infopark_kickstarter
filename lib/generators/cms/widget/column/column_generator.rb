module Cms
  module Generators
    module Widget
      class ColumnGenerator < ::Rails::Generators::Base
        include BasePaths
        include Example
        include Actions
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
              widget.attributes = column_attributes + column_size_attributes
            end

            template('en.locale.yml', "#{widget_path_for(folder_name)}/locales/en.#{folder_name}.yml", force: true)
            template(
              'show.html.haml',
              "app/widgets/#{folder_name}/views/show.html.haml",
              force: true
            )

            template(
              'edit.html.haml',
              "app/widgets/#{folder_name}/views/edit.html.haml",
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

        def column_size_attributes
          (1..columns).inject([]) do |array, index|
            array + [{
              name: column_size_name(index),
              type: :string,
              default: (12 / columns),
              title: column_size_title(index),
            }]
          end
        end

        def column_attributes
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
          "Column#{columns}Widget"
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

        def column_size_name(column)
          "column_#{column}_width".to_sym
        end

        def column_size_title(column)
          "Column #{column} width"
        end
      end
    end
  end
end
