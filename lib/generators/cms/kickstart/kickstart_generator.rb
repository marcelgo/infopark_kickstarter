require 'uri'

module Cms
  module Generators
    class KickstartGenerator < ::Rails::Generators::Base
      include Migration
      include BasePaths
      include Actions

      class_option :configuration_path,
        type: :string,
        default: nil,
        desc: 'Path to a JSON configuration file.'

      source_root File.expand_path('../templates', __FILE__)

      def initialize(args = [], options = {}, config = {})
        options << '--force'

        super(args, options, config)
      end

      def read_config_file
        path = options[:configuration_path]

        if path
          contents = if URI(path).is_a?(URI::HTTP)
            open(path, 'Accept' => 'application/json') { |io| io.read }
          else
            File.read(path)
          end

          configuration = JSON(contents)

          configuration.each do |generator|
            name = generator['name']
            options = Array(generator['options'])

            Rails::Generators.invoke(name, options, behavior: behavior)
          end
        end
      end

      def install_gems
        gem('active_attr')
        gem('simple_form')
        gem('haml-rails')
        gem('cells')

        gem_group(:assets) do
          gem('less-rails-bootstrap')
        end
      end

      def form_tools
        generate('simple_form:install --bootstrap --template-engine=haml')

        remove_file('config/locales/simple_form.de.yml')
        remove_file('config/locales/simple_form.en.yml')
        remove_dir('lib/templates')
      end

      def crm_initializer
        path = Rails.root + 'config/initializers/crm_connector.rb'

        if File.exist?(path)
          remove_file(path)
        end
      end

      def remove_erb_layout
        path = Rails.root + 'app/views/layouts/application.html.erb'

        if File.exist?(path)
          remove_file(path)
        end
      end

      def update_rails_configuration
        gsub_file(
          'config/application.rb',
          "# config.i18n.load_path += Dir[Rails.root.join('my', 'locales', '*.{rb,yml}').to_s]",
          "config.i18n.load_path += Dir[Rails.root + 'app/widgets/**/locales/*']"
        )

        log(:info, 'enable widget locales')
      end

      def create_structure_migration_file
        begin
          Model::ApiGenerator.new(behavior: behavior) do |model|
            model.name = 'Image'
            model.type = :generic
            model.title = 'Resource: Image'
            model.attributes = [
              title_attribute,
            ]
          end
        rescue Cms::Generators::DuplicateResourceError
        end

        begin
          Model::ApiGenerator.new(behavior: behavior) do |model|
            model.name = 'Video'
            model.type = :generic
            model.title = 'Resource: Video'
            model.attributes = [
              title_attribute,
            ]
          end
        rescue Cms::Generators::DuplicateResourceError
        end

        begin
          class_name = 'Homepage'

          Model::ApiGenerator.new(behavior: behavior) do |model|
            model.name = class_name
            model.title = 'Page: Homepage'
            model.attributes = [
              title_attribute,
              show_in_navigation_attribute,
              sort_key_attribute,
              {
                name: 'error_not_found_page_link',
                type: :linklist,
                title: 'Error Not Found Page',
                max_size: 1,
              },
              {
                name: 'login_page_link',
                type: :linklist,
                title: 'Login Page',
                max_size: 1,
              },
              {
                name: 'locale',
                type: :string,
                title: 'Locale',
              },
              main_content_attribute,
            ]
          end

          Rails::Generators.invoke('cms:controller', [class_name])
        rescue Cms::Generators::DuplicateResourceError
        end

        begin
          Model::ApiGenerator.new(behavior: behavior) do |model|
            model.name = 'Root'
            model.title = 'Root'
          end
        rescue Cms::Generators::DuplicateResourceError
        end

        begin
          Model::ApiGenerator.new(behavior: behavior) do |model|
            model.name = 'Website'
            model.title = 'Website'
          end
        rescue Cms::Generators::DuplicateResourceError
        end

        begin
          Model::ApiGenerator.new(behavior: behavior) do |model|
            model.name = 'Container'
            model.title = 'Container'
            model.attributes = [
              title_attribute,
              show_in_navigation_attribute,
            ]
          end
        rescue Cms::Generators::DuplicateResourceError
        end

        begin
          class_name = 'ContentPage'

          Model::ApiGenerator.new(behavior: behavior) do |model|
            model.name = class_name
            model.title = 'Page: Content'
            model.attributes = [
              title_attribute,
              show_in_navigation_attribute,
              sort_key_attribute,
              main_content_attribute,
            ]
          end

          Rails::Generators.invoke('cms:controller', [class_name])

          turn_model_into_page(class_name)
        rescue Cms::Generators::DuplicateResourceError
        end

        begin
          class_name = 'ErrorPage'

          Model::ApiGenerator.new(behavior: behavior) do |model|
            model.name = class_name
            model.title = 'Page: Error'
            model.attributes = [
              title_attribute,
              content_attribute,
              show_in_navigation_attribute,
            ]
          end

          Rails::Generators.invoke('cms:controller', [class_name])

          turn_model_into_page(class_name)
        rescue Cms::Generators::DuplicateResourceError
        end

        begin
          class_name = 'LoginPage'

          Model::ApiGenerator.new(behavior: behavior) do |model|
            model.name = class_name
            model.title = 'Page: Login'
            model.attributes = [
              title_attribute,
              content_attribute,
              show_in_navigation_attribute,
              sort_key_attribute,
            ]
          end

          Rails::Generators.invoke('cms:controller', [class_name])

          turn_model_into_page(class_name)
        rescue Cms::Generators::DuplicateResourceError
        end

        migration_template('create_structure.rb', 'cms/migrate/create_structure.rb')
      end

      def copy_app_directory
        directory('app', force: true)
        directory('lib')
        directory('config')
        directory('deploy')
      end

      def extend_gitignore
        append_file('.gitignore', "config/deploy.yml\n")
        append_file('.gitignore', "config/rails_connector.yml\n")
        append_file('.gitignore', "config/custom_cloud.yml\n")
      end

      def add_initial_content
        Rails::Generators.invoke('cms:component:search')
        Rails::Generators.invoke('cms:widget:text', ['--example'])
        Rails::Generators.invoke('cms:widget:image', ['--example'])
      end

      private

      def show_in_navigation_attribute
        {
          name: 'show_in_navigation',
          type: :boolean,
          title: 'Show in Navigation',
        }
      end

      def sort_key_attribute
        {
          name: 'sort_key',
          type: :string,
          title: 'Sort key',
        }
      end

      def main_content_attribute
        {
          name: 'main_content',
          type: :widget,
          title: 'Main content',
        }
      end

      def title_attribute
        {
          name: 'headline',
          type: :string,
          title: 'Headline',
        }
      end

      def content_attribute
        {
          name: 'content',
          type: :html,
          title: 'Content',
        }
      end
    end
  end
end