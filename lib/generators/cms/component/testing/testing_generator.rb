module Cms
  module Generators
    module Component
      class TestingGenerator < ::Rails::Generators::Base
        source_root File.expand_path('../templates', __FILE__)

        class_option :skip_bundle,
          type: :boolean,
          default: false,
          desc: 'Skip bundle command'

        class_option :skip_install,
          type: :boolean,
          default: false,
          desc: 'Skip rspec install command'

        def install_gems
          gem_group(:test, :development) do
            gem('rspec-rails')
          end

          unless options[:skip_bundle]
            Bundler.with_clean_env do
              run('bundle --quiet')
            end
          end
        end

        def install_test_framework
          unless options[:skip_install]
            generate('rspec:install')

            comment_lines 'spec/spec_helper.rb', 'config.fixture_path = "#{::Rails.root}/spec/fixtures"'
            comment_lines 'spec/spec_helper.rb', 'config.use_transactional_fixtures = true'
          end
        end
      end
    end
  end
end
