module Cms
  module Generators
    module Component
      class SearchGenerator < ::Rails::Generators::Base
        include Migration
        include BasePaths
        include Actions

        class_option :homepage_path,
          :type => :string,
          :default => nil,
          :desc => 'Path to a CMS homepage, for which to enable search.'

        source_root File.expand_path('../templates', __FILE__)

        def extend_homepage
          add_model_attribute('Homepage', search_page_attribute_name)
        end

        def extend_view
          file = 'app/views/layouts/application.html.haml'
          insert_point = "          .span3\n"

          data = []

          data << "            = render_cell(:search, :form, @obj, @query)\n"
          data << ''

          data = data.join("\n")

          insert_into_file(file, data, :after => insert_point)
        end

        def create_migration
          begin
            class_name = 'SearchPage'

            Model::ApiGenerator.new(behavior: behavior) do |model|
              model.name = class_name
              model.title = 'Page: Search'
              model.attributes = [
                show_in_navigation_attribute,
              ]
            end

            Rails::Generators.invoke('cms:controller', [class_name])

            turn_model_into_page(class_name)
          rescue Cms::Generators::DuplicateResourceError
          end

          migration_template('example_migration.rb', 'cms/migrate/create_search_page_example.rb')
        end

        def copy_app_directory
          directory('app', force: true)
          directory('config', force: true)
          directory('spec', force: true)
        end

        def notice
          if behavior == :invoke
            log(:migration, 'Make sure to run "rake cms:migrate" to apply CMS changes and "bundle" to install new gem.')
          end
        end

        private

        alias_method :original_homepage_path, :homepage_path
        def homepage_path
          options[:homepage_path] || original_homepage_path
        end

        def show_in_navigation_attribute_name
          'show_in_navigation'
        end

        def search_page_attribute_name
          'search_page_link'
        end

        def class_name
          'SearchPage'
        end
      end
    end
  end
end