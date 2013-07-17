module Cms
  module Generators
    module Component
      class TourGenerator < ::Rails::Generators::Base
        include Example
        include Migration
        include Actions
        include BasePaths

        source_root File.expand_path('../templates', __FILE__)

        def copy_app_directory
          directory('app')
        end

        def update_javascript_manifest
          insert_into_javascript_manifest('infopark_rails_connector', 'infopark_tour')
        end

        def update_stylesheet_manifest
          insert_into_stylesheet_manifest('infopark_rails_connector', 'infopark_tour')
        end

        def create_example
          if example?
            migration_template('example_migration.rb', "#{migration_path}/create_tour_example.rb")

            file_name = 'infopark_tour.config.js.coffee'
            template(file_name, File.join('app/assets/javascripts', file_name))

            insert_into_javascript_manifest('infopark_tour', 'infopark_tour.config')

            file = 'app/views/layouts/application.html.haml'
            insert_point = '      = render_cell(:footer, :show, @obj)'

            data = []
            data << "\n"
            data << "    = render 'tour/tour'"

            data = data.join("\n")

            insert_into_file(file, data, after: insert_point)

            if behavior == :invoke
              log(:migration, 'Make sure to run "rake cms:migrate" to apply CMS changes')
            end
          end
        end
      end
    end
  end
end