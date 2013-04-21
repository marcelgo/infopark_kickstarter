module Cms
  module Attributes
    module GoogleAnalyticsLink
      def google_analytics_link
        self[:google_analytics_link] || RailsConnector::LinkList.new(nil)
      end

      def google_analytics_link?
        google_analytics_link.present?
      end
    end
  end
end