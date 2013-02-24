require 'uri'
require 'generators/cms/migration'

module Cms
  module Generators
    class KickstartGenerator < ::Rails::Generators::Base
      include Migration

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

      def form_tools
        gem('active_attr', '0.7.0')
        gem('simple_form', '2.0.4')

        Bundler.with_clean_env do
          run('bundle --quiet')
        end

        generate('simple_form:install --bootstrap --template-engine=haml')

        remove_file('config/locales/simple_form.de.yml')
        remove_dir('lib/templates')
      end

      def include_dev_tools
        gem_group(:test, :development) do
          gem('pry-rails', '0.2.2')
          gem('rails-footnotes', '3.7.9')
          gem('better_errors', '0.5.0')
          gem('binding_of_caller', '0.6.8')
        end

        developer_initializer_path = 'config/initializers/developer.rb'
        append_file('.gitignore', developer_initializer_path)
        template('developer.rb', developer_initializer_path)
      end

      def install_test_framework
        gem_group(:test, :development) do
          gem('rspec-rails', '2.12.2')
        end

        Bundler.with_clean_env do
          run('bundle --quiet')
        end

        generate('rspec:install')
      end

      def create_deploy_hooks
        create_file('deploy/after_restart.rb')
        create_file('deploy/before_symlink.rb')
        prepend_file('deploy/before_migrate.rb', 'deploy/before_migrate.rb')
        empty_directory('deploy/templates')
      end

      def include_and_configure_template_engine
        gem('haml-rails', '0.4')

        application_erb_file = 'app/views/layouts/application.html.erb'

        if File.exist?(application_erb_file)
          remove_file(application_erb_file)
        end
      end

      def install_css_framework
        gem_group(:assets) do
          gem('less-rails-bootstrap', '2.2.1')
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

      def set_default_language
        gsub_file(
          'config/application.rb',
          "# config.i18n.default_locale = :de",
          "config.i18n.default_locale = :de"
        )

        remove_file('config/locales/en.yml')

        log(:info, "set default language to 'de'")
      end

      def rails_connector_monkey_patch
        template('date_attribute.rb', 'config/initializers/date_attribute.rb')
      end

      def configure_editmarker
        template('preview.js.coffee', 'app/assets/javascripts/preview.js.coffee')
      end

      def create_structure_migration_file
        Rails::Generators.invoke('cms:attribute', ['show_in_navigation', '--title=Show in Navigation', '--type=enum', '--values=Yes', 'No'])
        Rails::Generators.invoke('cms:attribute', ['error_404_page_link', '--title=Error 404 Page', '--type=linklist'])
        Rails::Generators.invoke('cms:attribute', ['login_page_link', '--title=Login Page', '--type=linklist'])
        Rails::Generators.invoke('cms:attribute', ['search_page_link', '--title=Search Page', '--type=linklist'])
        Rails::Generators.invoke('cms:attribute', ['locale', '--title=Locale', '--type=string'])
        Rails::Generators.invoke('cms:scaffold', ['Homepage', '--title=Page: Homepage', '--attributes=error_404_page_link', 'login_page_link', 'search_page_link', 'locale', 'show_in_navigation'])

        Rails::Generators.invoke('cms:model', ['Root', '--title=Root'])
        Rails::Generators.invoke('cms:model', ['Website', '--title=Website'])
        Rails::Generators.invoke('cms:model', ['Container', '--title=Container', '--attributes=show_in_navigation'])

        Rails::Generators.invoke('cms:attribute', ['sort_key', '--type=string', '--title=Sort Key'])
        Rails::Generators.invoke('cms:scaffold', ['ContentPage', '--title=Page: Content', '--attributes=show_in_navigation', 'sort_key'])
        Rails::Generators.invoke('cms:scaffold', ['ErrorPage', '--title=Page: Error', '--attributes=show_in_navigation'])
        Rails::Generators.invoke('cms:scaffold', ['SearchPage', '--title=Page: Search', '--attributes=show_in_navigation'])

        Rails::Generators.invoke('cms:attribute', ['redirect_after_login_link', '--type=linklist', '--title=Login Redirect', '--max-size=1'])
        Rails::Generators.invoke('cms:attribute', ['redirect_after_logout_link', '--type=linklist', '--title=Logout Redirect', '--max-size=1'])
        Rails::Generators.invoke('cms:scaffold', ['LoginPage', '--title=Page: Login', '--attributes=show_in_navigation', 'redirect_after_login_link', 'redirect_after_logout_link'])

        Rails::Generators.invoke('cms:attribute', ['redirect_link', '--type=linklist', '--title=Redirect Link', '--max-size=1'])
        Rails::Generators.invoke('cms:model', ['Redirect', '--title=Redirect', '--attributes=sort_key', 'redirect_link', 'show_in_navigation'])

        migration_template('create_structure.rb', 'cms/migrate/create_structure.rb')

        route("match ':id/login' => 'login_page#index', as: 'login_page'")
      end

      def copy_app_directory
        directory('app')
        directory('lib')
        directory('config')
        directory('deploy')
        directory('spec')
      end

      def extend_gitignore
        append_file('.gitignore', 'config/deploy.yml')
      end

      def create_box_model
        gem('cells', '3.8.8')

        template('cells_error_handling.rb', 'config/initializers/cells.rb')
      end

      def bundle
        Bundler.with_clean_env do
          run('bundle --quiet')
        end
      end

      def add_initital_components
        Rails::Generators.invoke('cms:widget:text', ["--cms_path=#{boxes_path}"])
        Rails::Generators.invoke('cms:widget:image', ["--cms_path=#{boxes_path}"])
        Rails::Generators.invoke('cms:widget:google_maps', ["--cms_path=#{boxes_path}"])
      end

      private

      def tenant_name
        content = File.read("#{Rails.root}/config/rails_connector.yml")

        YAML.load(content)['cms_api']['http_host']
      end

      def website_path
        '/website'
      end

      def resources_path
        '/resources'
      end

      def homepage_path
        "#{website_path}/de"
      end

      def configuration_path
        "#{homepage_path}/_configuration"
      end

      def boxes_path
        "#{homepage_path}/_boxes"
      end
    end
  end
end