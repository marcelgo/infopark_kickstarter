require 'spec_helper'

require 'generator_spec/test_case'
require 'rails/generators/test_case'
require 'generators/cms/widget/video/video_generator.rb'
require 'generators/cms/attribute/attribute_generator'
require 'generators/cms/model/model_generator'

describe Cms::Generators::Widget::VideoGenerator do
  include GeneratorSpec::TestCase

  destination File.expand_path('../../../../tmp', __FILE__)

  arguments ['--cms_path=testdirectory']

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
    javascripts_path = "#{destination_root}/app/assets/javascripts"
    stylesheets_path = "#{destination_root}/app/assets/stylesheets"

    mkdir_p(javascripts_path)
    mkdir_p(stylesheets_path)

    File.open("#{javascripts_path}/application.js", 'w') { |file| file.write("//= require infopark_rails_connector\n") }
    File.open("#{stylesheets_path}/application.css", 'w') { |file| file.write("*= require infopark_rails_connector\n") }
    File.open("#{destination_root}/Gemfile", 'w')
  end

  it 'creates files' do
    destination_root.should have_structure {
      directory 'app' do
        directory 'cells' do
          directory 'box' do
            file 'box_video_cell.rb'

            directory 'box_video' do
              file 'show.html.haml'
              file 'generic.html.haml'
              file 'youtube.html.haml'
              file 'vimeo.html.haml'
            end
          end
        end

        directory 'models' do
          file 'box_video.rb' do
            contains 'include Box'
            contains 'include Cms::Attributes::VideoLink'
            contains 'include Cms::Attributes::VideoWidth'
            contains 'include Cms::Attributes::VideoHeight'
            contains 'include Cms::Attributes::VideoAutoplay'
            contains 'include Cms::Attributes::VideoPreviewImage'
            contains 'include Cms::Attributes::SortKey'
          end
        end

        directory 'concerns' do
          directory 'cms' do
            directory 'attributes' do
              file 'sort_key.rb'
              file 'video_link.rb'
              file 'video_width.rb'
              file 'video_height.rb'
              file 'video_autoplay.rb'
              file 'video_preview_image.rb'
            end
          end
        end

        directory 'assets' do
          directory 'javascripts' do
            file 'application.js' do
              contains '//= require projekktor'
            end
          end

          directory 'stylesheets' do
            file 'application.css' do
              contains '*= require projekktor'
            end
          end
        end
      end

      directory 'cms' do
        directory 'migrate' do
          migration 'create_box_video'
          migration 'create_box_video_example'
        end
      end

      directory 'spec' do
        directory 'models' do
          file 'box_video_spec.rb'
        end
      end

      file 'Gemfile' do
        contains 'gem "video_info"'
        contains 'gem "projekktor-rails"'
      end
    }
  end
end