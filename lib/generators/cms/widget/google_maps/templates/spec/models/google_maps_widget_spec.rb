require 'spec_helper'

describe GoogleMapsWidget do
  it 'inherits from Obj' do
    subject.should be_a(Obj)
  end

  describe '#google_maps_address' do
    let(:address) { 'test address' }

    describe 'address' do
      it 'returns address' do
        subject.stub(:[]).with(:address).and_return(address)
        subject.address.should eq(address)
      end
    end
  end
end