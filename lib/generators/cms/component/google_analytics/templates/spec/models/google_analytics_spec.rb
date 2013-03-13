require 'spec_helper'

describe GoogleAnalytics do
  it 'inherits from Obj' do
    subject.should be_a(Obj)
  end

  describe 'anonymize_ip' do
    it 'returns true on "Yes"' do
      subject.stub(:[]).with(:google_analytics_anonymize_ip).and_return('Yes')
      subject.google_analytics_anonymize_ip?.should be_true
    end

    it 'returns false on "NO"' do
      subject.stub(:[]).with(:google_analytics_anonymize_ip).and_return('No')
      subject.google_analytics_anonymize_ip?.should be_false
    end

    it 'returns false on nil' do
      subject.stub(:[]).with(:google_analytics_anonymize_ip).and_return(nil)
      subject.google_analytics_anonymize_ip?.should be_false
    end
  end

  describe 'tracking_id' do
    it 'returns 123 on 123' do
      subject.stub(:[]).with(:google_analytics_tracking_id).and_return('123')
      subject.google_analytics_tracking_id.should eq('123')
    end

    it 'returns empty string on nil' do
      subject.stub(:[]).with(:google_analytics_tracking_id).and_return(nil)
      subject.google_analytics_tracking_id.should eq('')
    end
  end
end