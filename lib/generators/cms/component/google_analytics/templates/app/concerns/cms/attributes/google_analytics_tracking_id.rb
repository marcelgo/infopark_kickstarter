module Cms
  module Attributes
    module GoogleAnalyticsTrackingId
      def tracking_id
        self[:google_analytics_tracking_id].to_s
      end
    end
  end
end