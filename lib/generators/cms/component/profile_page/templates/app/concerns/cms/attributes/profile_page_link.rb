module Cms
  module Attributes
    module ProfilePageLink
      def profile_page_link
        self[:profile_page_link] || RailsConnector::LinkList.new(nil)
      end

      def profile_page_link?
        profile_page_link.present?
      end

      def profile_page
        profile_page_link.destination_objects.first
      end
    end
  end
end