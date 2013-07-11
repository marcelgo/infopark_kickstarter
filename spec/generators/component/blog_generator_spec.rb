require 'spec_helper'

require 'generator_spec/test_case'
require 'generators/cms/component/blog/blog_generator'

describe Cms::Generators::Component::BlogGenerator do
  include GeneratorSpec::TestCase

  destination File.expand_path('../../../../tmp/generators', __FILE__)

  before do
    prepare_destination
    prepare_environments
    run_generator
  end

  def prepare_environments
    paths = {
      layout_path: "#{destination_root}/app/views/layouts",
    }

    paths.each do |_, path|
      mkdir_p(path)
    end

    File.open("#{destination_root}/Gemfile", 'w')
    File.open("#{paths[:layout_path]}/application.html.haml", 'w') { |f| f.write("%link{href: '/favicon.ico', rel: 'shortcut icon'}\n") }
  end

  it 'create files' do
    destination_root.should have_structure {
      directory 'app' do
        directory 'models' do
          file 'blog.rb' do
            contains 'cms_attribute :headline, type: :string'
            contains 'cms_attribute :show_in_navigation, type: :boolean'
            contains 'cms_attribute :sort_key, type: :string'
            contains 'cms_attribute :disqus_shortname, type: :string'
            contains 'cms_attribute :description, type: :text'
          end

          file 'blog_post.rb' do
            contains 'cms_attribute :headline, type: :string'
            contains 'cms_attribute :author, type: :string'
          end
        end

        directory 'views' do
          directory 'blog' do
            file 'index.html.haml'
            file 'index.rss.builder'
          end

          directory 'blog_post' do
            file 'index.html.haml'
          end

          directory 'layouts' do
            file 'application.html.haml' do
              contains '= render_cell(:blog, :discovery, @obj)'
            end
          end
        end

        directory 'cells' do
          file 'blog_cell.rb'

          directory 'blog' do
            file 'posts.html.haml'
            file 'posts.rss.builder'
            file 'post.html.haml'
            file 'post.rss.builder'
            file 'discovery.html.haml'
            file 'comment.html.haml'
            file 'snippet.html.haml'
            file 'snippet.rss.builder'
            file 'published_by.html.haml'
            file 'published_at.html.haml'
            file 'gravatar.html.haml'
            file 'post_details.html.haml'
          end
        end

        directory 'controllers' do
          file 'blog_controller.rb'
          file 'blog_post_controller.rb'
        end
      end

      directory 'config' do
        directory 'locales' do
          file 'en.blog.yml'
        end
      end

      file 'Gemfile' do
        contains 'gem "gravatar_image_tag"'
      end
    }
  end
end