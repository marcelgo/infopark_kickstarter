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
          class_name = 'Image'
          validate_obj_class(class_name)

          Rails::Generators.invoke('cms:model', [class_name, '--type=generic', '--title=Resource: Image'])
        rescue Cms::Generators::DuplicateResourceError
        end

        begin
          class_name = 'Video'
          validate_obj_class(class_name)

          Rails::Generators.invoke('cms:model', [class_name, '--type=generic', '--title=Resource: Video'])
        rescue Cms::Generators::DuplicateResourceError
        end

        Rails::Generators.invoke('cms:attribute', ['show_in_navigation', '--title=Show in Navigation', '--type=boolean'])
        Rails::Generators.invoke('cms:attribute', ['error_not_found_page_link', '--title=Error Not Found Page', '--type=linklist'])
        Rails::Generators.invoke('cms:attribute', ['login_page_link', '--title=Login Page', '--type=linklist'])
        Rails::Generators.invoke('cms:attribute', ['locale', '--title=Locale', '--type=string'])
        Rails::Generators.invoke('cms:scaffold', ['Homepage', '--title=Page: Homepage', '--attributes=error_not_found_page_link', 'login_page_link', 'locale', 'show_in_navigation'])

        Rails::Generators.invoke('cms:model', ['Root', '--title=Root'])
        Rails::Generators.invoke('cms:model', ['Website', '--title=Website'])
        Rails::Generators.invoke('cms:model', ['Container', '--title=Container', '--attributes=show_in_navigation'])

        Rails::Generators.invoke('cms:attribute', ['sort_key', '--type=string', '--title=Sort Key'])

        Rails::Generators.invoke('cms:scaffold', ['ContentPage', '--title=Page: Content', '--attributes=show_in_navigation', 'sort_key'])
        turn_model_into_page('ContentPage')

        Rails::Generators.invoke('cms:scaffold', ['ErrorPage', '--title=Page: Error', '--attributes=show_in_navigation'])

        Rails::Generators.invoke('cms:attribute', ['redirect_after_login_link', '--type=linklist', '--title=Login Redirect', '--max-size=1'])
        Rails::Generators.invoke('cms:attribute', ['redirect_after_logout_link', '--type=linklist', '--title=Logout Redirect', '--max-size=1'])
        Rails::Generators.invoke('cms:scaffold', ['LoginPage', '--title=Page: Login', '--attributes=show_in_navigation', 'redirect_after_login_link', 'redirect_after_logout_link'])
        turn_model_into_page('LoginPage')

        Rails::Generators.invoke('cms:attribute', ['redirect_link', '--type=linklist', '--title=Redirect Link', '--max-size=1'])
        Rails::Generators.invoke('cms:model', ['Redirect', '--title=Redirect', '--attributes=sort_key', 'redirect_link', 'show_in_navigation'])
        turn_model_into_page('Redirect')

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

      def tenant_name
        content = File.read("#{Rails.root}/config/rails_connector.yml")

        YAML.load(content)['cms_api']['http_host']
      end
    end
  end
end