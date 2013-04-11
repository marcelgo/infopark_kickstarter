require 'spec_helper'

describe SearchPageController do
  it 'inherits from CmsController' do
    subject.should be_a(CmsController)
  end
end