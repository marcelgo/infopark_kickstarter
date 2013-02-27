module Cms
  module Attributes
    module GoogleAnalyticsAnonymizeIp
      def google_analytics_anonymize_ip
        self[:google_analytics_anonymize_ip].to_s
      end

      def anonymize_ip?
        google_analytics_anonymize_ip == 'Yes'
      end
    end
  end
end