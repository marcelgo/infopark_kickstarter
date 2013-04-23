module Cms
  module Generators
    module Component
      class TestingGenerator < ::Rails::Generators::Base
        source_root File.expand_path('../templates', __FILE__)

        def install_gems
          gem_group(:test, :development) do
            gem('rspec-rails')
          end

          Bundler.with_clean_env do
            run('bundle --quiet')
          end
        end

        def install_test_framework
          generate('rspec:install')
        end
      end
    end
  end
end