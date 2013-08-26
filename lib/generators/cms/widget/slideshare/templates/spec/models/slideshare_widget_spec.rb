require 'spec_helper'

describe SlideshareWidget do
  it 'inherits from Obj' do
    subject.should be_a(Obj)
  end

  describe '#embed_html' do
    it 'should catch malformed JSON responses' do
      expect(subject).to receive(:source_url).at_least(:once) { 'http://www.slideshare.net/' }

      RestClient.should_receive(:get).and_return('{[]}')
      Rails.logger.should_receive(:error)

      expect(subject.embed_html).to be_blank
    end
  end
end