require 'spec_helper'

describe BoxGoogleMaps do
  it 'inherits from Obj' do
    subject.should be_a(Obj)
  end

  describe 'pins' do
    it 'returns an array on [GoogleMapsPin.new]' do
      subject.stub(:pins).and_return([GoogleMapsPin.new])
      subject.pins.should be_an_instance_of(Array)
      subject.pins.count.should eq(1)
    end
  end

  describe '#google_maps_address' do
    let(:address) { 'test address' }
    let(:coordinate) { mock(Geocoder::Result::Google, :latitude => 48.78322, :longitude => 52.78322) }

    before do
      subject.stub(:[]).with(:google_maps_address).and_return(address)
      Geocoder.stub(:search).with(address).and_return([coordinate])
    end

    describe 'latitude' do
      it 'returns geocode latitude' do
        subject.latitude.should eq(coordinate.latitude)
      end
    end

    describe 'longitude' do
      it 'returns geocode longitude' do
        subject.longitude.should eq(coordinate.longitude)
      end
    end
  end

  describe 'google_maps_map_type' do
    it 'returns ROADMAP on ROADMAP' do
      subject.stub(:google_maps_map_type).and_return('ROADMAP')
      subject.google_maps_map_type.should eq('ROADMAP')
    end
  end
end