require 'spec_helper'

require 'generator_spec/test_case'
require 'generators/cms/component/share/share_generator.rb'

describe Cms::Generators::Component::ShareGenerator do
  include GeneratorSpec::TestCase

  destination File.expand_path('../../../../tmp', __FILE__)

  before do
    run_generator
  end

  it 'creates files' do
    destination_root.should have_structure {
      directory 'app' do
        directory 'cells' do
          file 'share_cell.rb'

          directory 'share' do
            file 'facebook.html.haml'
            file 'google.html.haml'
            file 'linkedin.html.haml'
            file 'show.html.haml'
            file 'twitter.html.haml'
          end
        end
      end
    }
  end
end