require 'uri'

module Cms
  module Generators
    class KickstartGenerator < ::Rails::Generators::Base
      include Migration
      include BasePaths
      include Actions

      source_root File.expand_path('../templates', __FILE__)
      class_option :configuration_path, type: :string, default: nil, desc: 'Path to a JSON configuration file.'

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

        gem_group(:test, :development) do
          gem('pry-rails')
          gem('better_errors')
          gem('binding_of_caller')
          gem('rspec-rails')
        end

        Bundler.with_clean_env do
          run('bundle --quiet')
        end
      end

      def form_tools
        generate('simple_form:install --bootstrap --template-engine=haml')

        remove_file('config/locales/simple_form.de.yml')
        remove_file('config/locales/simple_form.en.yml')
        remove_dir('lib/templates')
      end

      def include_dev_tools
        developer_initializer_path = 'config/initializers/developer.rb'
        append_file('.gitignore', developer_initializer_path + "\n")
        template('developer.rb', developer_initializer_path)
      end

      def install_test_framework
        generate('rspec:install')
      end

      def create_deploy_hooks
        empty_directory('deploy/templates')

        create_file('deploy/after_restart.rb')
        create_file('deploy/before_symlink.rb')

        destination = 'deploy/before_migrate.rb'

        unless File.exist?(destination)
          create_file(destination)
        end

        prepend_file(destination) do
          File.read(find_in_source_paths('deploy/before_migrate.rb'))
        end
      end

      def include_and_configure_template_engine
        application_erb_file = 'app/views/layouts/application.html.erb'

        if File.exist?(application_erb_file)
          remove_file(application_erb_file)
        end
      end

      def set_timezone
        gsub_file(
          'config/application.rb',
          "# config.time_zone = 'Central Time (US & Canada)'",
          "config.time_zone = 'Berlin'"
        )

        log(:info, "set timezone to 'Berlin'")
      end

      def rails_connector_monkey_patch
        template('date_attribute.rb', 'config/initializers/date_attribute.rb')
      end

      def create_structure_migration_file
        begin
          Model::ApiGenerator.new(behavior: behavior) do |model|
            model.name = 'Image'
            model.type = :generic
            model.title = 'Resource: Image'
          end
        rescue Cms::Generators::DuplicateResourceError
        end

        begin
          Model::ApiGenerator.new(behavior: behavior) do |model|
            model.name = 'Video'
            model.type = :generic
            model.title = 'Resource: Video'
          end
        rescue Cms::Generators::DuplicateResourceError
        end

        begin
          class_name = 'Homepage'

          Model::ApiGenerator.new(behavior: behavior) do |model|
            model.name = class_name
            model.title = 'Page: Homepage'
            model.attributes = [
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
                name: 'search_page_link',
                type: :linklist,
                title: 'Search Page',
                max_size: 1,
              },
              {
                name: 'locale',
                type: :string,
                title: 'Locale',
              },
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
              show_in_navigation_attribute,
              sort_key_attribute,
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
              show_in_navigation_attribute,
              {
                name: 'redirect_after_login_link',
                type: :linklist,
                title: 'Login redirect',
                max_size: 1,
              },
              {
                name: 'redirect_after_logout_link',
                type: :linklist,
                title: 'Logout redirect',
                max_size: 1,
              }
            ]
          end

          Rails::Generators.invoke('cms:controller', [class_name])

          turn_model_into_page(class_name)
        rescue Cms::Generators::DuplicateResourceError
        end

        begin
          class_name = 'Redirect'

          Model::ApiGenerator.new(behavior: behavior) do |model|
            model.name = class_name
            model.title = 'Redirect'
            model.attributes = [
              show_in_navigation_attribute,
              sort_key_attribute,
              {
                name: 'redirect_link',
                type: :linklist,
                title: 'Redirect link',
                max_size: 1,
              },
            ]
          end

          turn_model_into_page(class_name)
        rescue Cms::Generators::DuplicateResourceError
        end

        migration_template('create_structure.rb', 'cms/migrate/create_structure.rb')

        route("match ':id/login' => 'login_page#index', as: 'login_page'")
      end

      def copy_app_directory
        directory('app', force: true)
        directory('lib')
        directory('config')
        directory('spec')

        template('homepage.rb', 'app/models/homepage.rb')
      end

      def extend_gitignore
        append_file('.gitignore', "config/deploy.yml\n")
      end

      def create_box_model
        template('cells_error_handling.rb', 'config/initializers/cells.rb')
      end

      def add_initital_components
        Rails::Generators.invoke('cms:component:search')
        Rails::Generators.invoke('cms:widget:text', ["--cms_path=#{widgets_path}"])
        Rails::Generators.invoke('cms:widget:image', ["--cms_path=#{widgets_path}"])
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

      def tenant_name
        content = File.read("#{Rails.root}/config/rails_connector.yml")

        YAML.load(content)['cms_api']['http_host']
      end
    end
  end
end