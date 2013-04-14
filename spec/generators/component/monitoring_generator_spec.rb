require 'spec_helper'

require 'generator_spec/test_case'
require 'generators/cms/component/monitoring/monitoring_generator'

describe Cms::Generators::Component::MonitoringGenerator do
  include GeneratorSpec::TestCase

  destination File.expand_path('../../../../tmp/generators', __FILE__)
  arguments ['Test',  '--provider=newrelic']

  before do
    prepare_destination
    run_generator
  end
end