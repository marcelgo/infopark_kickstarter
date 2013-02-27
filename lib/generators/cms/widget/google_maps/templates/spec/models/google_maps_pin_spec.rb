require 'spec_helper'

describe GoogleMapsPin do
  it 'inherits from Obj' do
    subject.should be_a(Obj)
  end

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