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
      javascripts_path: "#{destination_root}/app/assets/javascripts"
    }

    paths.each do |_, path|
      mkdir_p(path)
    end

    File.open("#{destination_root}/Gemfile", 'w')
    File.open("#{paths[:config_path]}/routes.rb", 'w') do |f|
      f.write('IceKickstarterTest::Application.routes.draw do')
      f.write("\n")
      f.write('end')
    end
    File.open("#{paths[:config_path]}/custom_cloud.yml", 'w')
    File.open("#{paths[:config_path]}/application.rb", 'w') { |f| f.write('require "rails/test_unit/railtie"') }
    File.open("#{paths[:javascripts_path]}/application.js", 'w') { |f| f.write('//= require infopark_rails_connector') }
  end

  it 'create model files' do
    destination_root.should have_structure do
      directory 'app' do
        directory 'models' do
          file 'blog.rb'
          file 'blog_entry.rb'
        end
      end
    end
  end

  it 'create views' do
    destination_root.should have_structure do
      directory 'app' do
        directory 'views' do
          directory 'blog' do
            file 'index.atom.builder'
            file 'index.html.haml'
            file 'index.rss.builder'
            file 'search.html.haml'
          end

          directory 'blog_entry' do
            file 'index.html.haml'
          end
        end
      end
    end
  end

  it 'create concerns' do
    destination_root.should have_structure do
      directory 'app' do
        directory 'concerns' do
          directory 'cms' do
            directory 'attributes' do
              file 'blog_disqus_shortname.rb'
              file 'blog_enable_disqus_comments.rb'
              file 'blog_enable_facebook_button.rb'
              file 'blog_enable_twitter_button.rb'
              file 'blog_entry_author_id.rb'
              file 'blog_entry_publication_date.rb'
              file 'blog_entry_tags.rb'
              file 'blog_entry_truncation.rb'
            end
          end
        end
      end
    end
  end

  it 'create cells' do
    destination_root.should have_structure do
      directory 'app' do
        directory 'cells' do
          file 'blog_cell.rb'
          file 'blog_entry_cell.rb'

          directory 'blog' do
            file 'disqus_snippet.html.haml'
            file 'search.html.haml'
            file 'search_sidebar.html.haml'
            file 'show.html.haml'
            file 'sidebar.html.haml'
            file 'tag_sidebar.html.haml'
          end

          directory 'blog_entry' do
            file 'comment.html.haml'
            file 'facebook.html.haml'
            file 'footer.html.haml'
            file 'header.html.haml'
            file 'preview.html.haml'
            file 'preview_footer.html.haml'
            file 'show.html.haml'
            file 'twitter.html.haml'

            directory 'box_previews' do
              file 'box_image_preview.html.haml'
              file 'box_missing_preview.html.haml'
              file 'box_text_preview.html.haml'
            end
          end
        end
      end
    end
  end

  it 'create javascript file' do
    destination_root.should have_structure do
      directory 'app' do
        directory 'assets' do
          directory 'javascripts' do
            file 'blog.js'
          end
        end
      end
    end
  end

  it 'create controllers' do
    destination_root.should have_structure do
      directory 'app' do
        directory 'controllers' do
          file 'blog_controller.rb'
          file 'blog_entry_controller.rb'
        end
      end
    end
  end

  it 'create stylesheet files' do
    destination_root.should have_structure do
      directory 'app' do
        directory 'assets' do
          directory 'stylesheets' do
            directory 'blog' do
              file 'base.css.scss'
              file 'boxes.css.scss'
            end
          end
        end
      end
    end
  end

  it 'create helper' do
    destination_root.should have_structure do
      directory 'app' do
        directory 'helpers' do
          file 'blog_helper.rb'
        end
      end
    end
  end

  it 'create service files' do
    destination_root.should have_structure do
      directory 'app' do
        directory 'services' do
          file 'blog_search_service.rb'
          file 'user_image_service.rb'
        end
      end
    end
  end

  it 'update routes' do
    destination_root.should have_structure do
      directory 'config' do
        file 'routes.rb' do
          contains "resources :blog, only: [:index] do"
          contains "post :search"
          contains "end"
        end
      end
    end
  end

  it 'update gemfile' do
    destination_root.should have_structure do
      file 'Gemfile' do
        contains 'gem "will_paginate"'
      end
    end
  end

  it 'update_application_rb' do
    destination_root.should have_structure do
      directory 'config' do
        file 'application.rb' do
          contains 'require "will_paginate/array"'
        end
      end
    end
  end

  it 'update_application_js' do
    destination_root.should have_structure do
      directory 'app' do
        directory 'assets' do
          directory 'javascripts' do
            file 'application.js' do
              contains '//= require blog'
            end
          end
        end
      end
    end
  end

end