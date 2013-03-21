require 'spec_helper'

require 'generator_spec/test_case'
require 'generators/cms/component/blog/blog_generator'
require 'generators/cms/attribute/attribute_generator'
require 'generators/cms/model/model_generator'

describe Cms::Generators::Component::BlogGenerator do
  include GeneratorSpec::TestCase

  destination File.expand_path('../../../../tmp', __FILE__)

  before(:all) do
    Cms::Generators::AttributeGenerator.send(:include, TestDestinationRoot)
    Cms::Generators::ModelGenerator.send(:include, TestDestinationRoot)
  end

  before do
    prepare_destination
    prepare_environments
    run_generator
  end

  def prepare_environments
    paths = {
      config_path: "#{destination_root}/config",
      layout_path: "#{destination_root}/app/views/layouts",
    }

    paths.each do |_, path|
      mkdir_p(path)
    end

    File.open("#{destination_root}/Gemfile", 'w')
    File.open("#{paths[:layout_path]}/application.html.haml", 'w') { |f| f.write("%link{href: '/favicon.ico', rel: 'shortcut icon'}") }
    File.open("#{paths[:config_path]}/custom_cloud.yml", 'w')
  end

  it 'create app files' do
    destination_root.should have_structure do
      directory 'app' do
        directory 'models' do
          file 'blog.rb'
          file 'blog_entry.rb'
        end

        directory 'views' do
          directory 'blog' do
            file 'index.html.haml'
            file 'index.rss.builder'
          end

          directory 'blog_entry' do
            file 'index.html.haml'
          end

          directory 'layouts' do
            file 'application.html.haml' do
              contains '= render_cell(:blog, :discovery, @obj)'
            end
          end
        end

        directory 'concerns' do
          directory 'cms' do
            directory 'attributes' do
              file 'blog_disqus_shortname.rb'
              file 'blog_description.rb'
              file 'blog_entry_author.rb'
            end
          end
        end

        directory 'cells' do
          file 'blog_cell.rb'

          directory 'blog' do
            file 'entries.html.haml'
            file 'entry.html.haml'
            file 'discovery.html.haml'
            file 'comment.html.haml'
            file 'snippet.html.haml'
            file 'published_by.html.haml'
            file 'published_at.html.haml'
            file 'gravatar.html.haml'
            file 'entry_details.html.haml'
          end
        end

        directory 'controllers' do
          file 'blog_controller.rb'
          file 'blog_entry_controller.rb'
        end
      end
    end
  end

  it 'update gemfile' do
    destination_root.should have_structure do
      file 'Gemfile' do
        contains 'gem "gravatar_image_tag"'
      end
    end
  end
end