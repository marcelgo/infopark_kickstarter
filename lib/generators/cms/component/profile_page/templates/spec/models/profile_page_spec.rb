require 'spec_helper'

describe ProfilePage do
  it 'inherits from Obj' do
    subject.should be_a(Obj)
  end

  it 'responds to show_in_navigation' do
    subject.should respond_to(:show_in_navigation)
  end

  it 'should be a Page' do
    subject.should be_a(Page)
  end
end