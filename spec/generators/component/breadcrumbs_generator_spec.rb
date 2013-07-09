require 'spec_helper'

require 'generator_spec/test_case'
require 'generators/cms/component/breadcrumbs/breadcrumbs_generator'

describe Cms::Generators::Component::BreadcrumbsGenerator do
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
      concerns_path: "#{destination_root}/app/concerns",
    }

    paths.each do |_, path|
      mkdir_p(path)
    end

    File.open("#{paths[:layout_path]}/application.html.haml", 'w') { |f| f.write("      .content\n") }
    File.open("#{paths[:concerns_path]}/page.rb", 'w') { |f| f.write("module Page\n") }
  end

  it 'create files' do
    destination_root.should have_structure {
      directory 'app' do
        directory 'concerns' do
          file 'page.rb' do
            contains '  def show_breadcrumbs?'
            contains '  def breadcrumbs'
          end
        end

        directory 'views' do
          directory 'layouts' do
            file 'application.html.haml' do
              contains '            = render_cell(:breadcrumbs, :show, @obj)'
            end
          end
        end

        directory 'cells' do
          file 'breadcrumbs_cell.rb'

          directory 'breadcrumbs' do
            file 'show.html.haml'
            file 'active.html.haml'
            file 'ancestor.html.haml'
          end
        end
      end
    }
  end
end