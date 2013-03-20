module Cms
  module Generators
    module Component
      class BlogGenerator < ::Rails::Generators::Base
        include Migration
        include BasePaths

        source_root File.expand_path('../templates', __FILE__)

        def create_migration
          begin
            validate_attribute(blog_disqus_shortname_attribute_name)

            Rails::Generators.invoke(
              'cms:attribute',
              [
                blog_disqus_shortname_attribute_name,
                '--type=string',
                '--title=Disqus Shortname',
                '--method_name=disqus_shortname'
              ]
            )
          rescue Cms::Generators::DuplicateResourceError
          end

          begin
            validate_attribute(blog_enable_disqus_comments_attribute_name)

            Rails::Generators.invoke(
              'cms:attribute',
              [
                blog_enable_disqus_comments_attribute_name,
                '--type=boolean',
                '--title=Enable Disqus Comments?',
                '--method_name=enable_disqus_comments',
                '--default=true'
              ]
            )
          rescue Cms::Generators::DuplicateResourceError
          end

          begin
            validate_attribute(blog_enable_facebook_button_attribute_name)

            Rails::Generators.invoke(
              'cms:attribute',
              [
                blog_enable_facebook_button_attribute_name,
                '--type=boolean',
                '--title=Enable Facebook Like Button?',
                '--method_name=enable_facebook_button'
              ]
            )
          rescue Cms::Generators::DuplicateResourceError
          end

          begin
            validate_attribute(blog_enable_twitter_button_attribute_name)

            Rails::Generators.invoke(
              'cms:attribute',
              [
                blog_enable_twitter_button_attribute_name,
                '--type=boolean',
                '--title=Enable Twitter Button?',
                '--method_name=enable_twitter_button'
              ]
            )
          rescue Cms::Generators::DuplicateResourceError
          end

          begin
            validate_attribute(blog_entry_truncation_attribute_name)

            Rails::Generators.invoke(
              'cms:attribute',
              [
                blog_entry_truncation_attribute_name,
                '--type=integer',
                '--title=Number of characters in preview',
                '--method_name=entry_truncation'
              ]
            )
          rescue Cms::Generators::DuplicateResourceError
          end

          begin
            validate_attribute(blog_entry_tags_attribute_name)

            Rails::Generators.invoke(
              'cms:attribute',
              [
                blog_entry_tags_attribute_name,
                '--type=string',
                '--title=Tags',
                '--method_name=tags'
              ]
            )
          rescue Cms::Generators::DuplicateResourceError
          end

          begin
            validate_attribute(blog_entry_author_id_attribute_name)

            Rails::Generators.invoke(
              'cms:attribute',
              [
                blog_entry_author_id_attribute_name,
                '--type=string',
                '--title=Author ID',
                '--method_name=author_id'
              ]
            )
          rescue Cms::Generators::DuplicateResourceError
          end

          begin
            validate_attribute(blog_entry_publication_date_attribute_name)

            Rails::Generators.invoke(
              'cms:attribute',
              [
                blog_entry_publication_date_attribute_name,
                '--type=string',
                '--title=Date',
                '--method_name=publish_date'
              ]
            )
          rescue Cms::Generators::DuplicateResourceError
          end

          begin
            validate_obj_class(blog_class_name)

            Rails::Generators.invoke(
              'cms:model',
              [
                blog_class_name,
                "--attributes=#{blog_entry_truncation_attribute_name}",
                blog_disqus_shortname_attribute_name,
                blog_enable_twitter_button_attribute_name,
                blog_enable_disqus_comments_attribute_name,
                blog_enable_facebook_button_attribute_name,
                '--title=Page: Blog'
              ]
            )
          rescue Cms::Generators::DuplicateResourceError
          end

          begin
            validate_obj_class(blog_entry_class_name)

            Rails::Generators.invoke(
              'cms:model',
              [
                blog_entry_class_name,
                "--attributes=#{blog_entry_tags_attribute_name}",
                blog_entry_author_id_attribute_name,
                blog_entry_publication_date_attribute_name,
                blog_enable_twitter_button_attribute_name,
                blog_enable_facebook_button_attribute_name,
                blog_enable_disqus_comments_attribute_name,
                '--title=Blog: Entry'
              ]
            )
          rescue Cms::Generators::DuplicateResourceError
          end
        end

        def create_example
          migration_template('example_migration.rb', 'cms/migrate/create_blog_example.rb')
        end

        def copy_app_directory
          directory('app', force: true)
        end

        def update_routes
          data = []

          data << 'resources :blog, only: [:index] do'
          data << '    post :search'
          data << '  end'
          data << ''
          data << "get ':id/blog_entry' , to: 'blog_entry#index', as: 'blog_entry'"

          data = data.join("\n")

          route(data)
        end

        def update_gemfile
          gem('will_paginate')

          Bundler.with_clean_env do
            run('bundle --quiet')
          end
        end

        # def update_application_rb
        #   file = 'config/application.rb'
        #   insert_point = 'require "rails/test_unit/railtie"'
        #   data = []

        #   data << ''
        #   data << 'require "will_paginate/array"'

        #   data = data.join("\n")

        #   insert_into_file(file, data, after: insert_point)
        # end

        def update_application_js
          file = 'app/assets/javascripts/application.js'
          insert_point = "//= require infopark_rails_connector"

          data = []
          data << ''
          data << '//= require blog'

          data = data.join("\n")

          insert_into_file(file, data, after: insert_point)
        end

        def notice
          if behavior == :invoke
            log(:migration, 'Make sure to run "rake cms:migrate" to apply CMS changes')
          end
        end

        private

        def blog_entry_truncation_attribute_name
          'blog_entry_truncation'
        end

        def blog_entry_tags_attribute_name
          'blog_entry_tags'
        end

        def blog_entry_author_id_attribute_name
          'blog_entry_author_id'
        end

        def blog_disqus_shortname_attribute_name
          'blog_disqus_shortname'
        end

        def blog_enable_disqus_comments_attribute_name
          'blog_enable_disqus_comments'
        end

        def blog_enable_facebook_button_attribute_name
          'blog_enable_facebook_button'
        end

        def blog_enable_twitter_button_attribute_name
          'blog_enable_twitter_button'
        end

        def blog_entry_publication_date_attribute_name
          'blog_entry_publication_date'
        end

        def blog_class_name
          'Blog'
        end

        def blog_entry_class_name
          'BlogEntry'
        end
      end
    end
  end
end