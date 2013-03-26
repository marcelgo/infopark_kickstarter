require 'spec_helper'

describe GoogleMapsWidget do
  it 'inherits from Obj' do
    subject.should be_a(Obj)
  end

  describe '#google_maps_address' do
    let(:address) { 'test address' }

    describe 'address' do
      it 'returns address' do
        subject.stub(:[]).with(:google_maps_address).and_return(address)
        subject.address.should eq(address)
      end
    end
  end

  describe 'google_maps_map_type' do
    it 'returns ROADMAP on ROADMAP' do
      subject.stub(:[]).with(:google_maps_map_type).and_return('ROADMAP')
      subject.map_type.should eq('ROADMAP')
    end
  end
end