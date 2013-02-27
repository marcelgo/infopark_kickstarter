module Cms
  module Attributes
    module ContactPageLink
      def contact_page_link
        self[:contact_page_link] || RailsConnector::LinkList.new(nil)
      end

      def contact_page_link?
        contact_page_link.present?
      end

      def contact_page
        contact_page_link.destination_objects.first
      end
    end
  end
end