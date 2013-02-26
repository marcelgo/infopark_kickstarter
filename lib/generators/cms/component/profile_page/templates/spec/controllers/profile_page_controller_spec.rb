require 'spec_helper'

describe ProfilePageController do
  it 'inherits from CmsController' do
    subject.should be_a(CmsController)
  end
end