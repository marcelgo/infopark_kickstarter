require 'spec_helper'

describe <%= class_name %> do
  it 'inherits from Obj' do
    subject.should be_a(Obj)
  end
end