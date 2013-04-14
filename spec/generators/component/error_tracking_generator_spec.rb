require 'spec_helper'

require 'generator_spec/test_case'
require 'generators/cms/component/error_tracking/error_tracking_generator'

describe Cms::Generators::Component::ErrorTrackingGenerator do
  include GeneratorSpec::TestCase

  destination File.expand_path('../../../../tmp/generators', __FILE__)
  arguments ['--provider=airbrake']

  before do
    prepare_destination
    run_generator
  end
end