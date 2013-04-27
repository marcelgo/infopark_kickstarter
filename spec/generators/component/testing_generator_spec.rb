require 'spec_helper'

require 'generator_spec/test_case'
require 'generators/cms/component/testing/testing_generator'

describe Cms::Generators::Component::TestingGenerator do
  include GeneratorSpec::TestCase

  destination File.expand_path('../../../../tmp/generators', __FILE__)
  arguments ['--skip-bundle', '--skip-install']

  before do
    prepare_destination
    prepare_environments
    run_generator
  end

  def prepare_environments
    File.open("#{destination_root}/Gemfile", 'w')
  end

  it 'integrates test framework' do
    destination_root.should have_structure {
      file 'Gemfile' do
        contains 'gem "rspec-rails"'
      end
    }
  end
end