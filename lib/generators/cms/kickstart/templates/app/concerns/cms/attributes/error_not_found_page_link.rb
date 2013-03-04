module Cms
  module Attributes
    module ErrorNotFoundPageLink
      def error_not_found_page_link
        self[:error_not_found_page_link] || RailsConnector::LinkList.new(nil)
      end

      def error_not_found_page_link?
        error_not_found_page_link.present?
      end

      def error_not_found_page
        error_not_found_page_link.destination_objects.first
      end
    end
  end
end