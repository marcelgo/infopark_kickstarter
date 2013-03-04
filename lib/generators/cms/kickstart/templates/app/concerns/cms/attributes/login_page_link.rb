module Cms
  module Attributes
    module LoginPageLink
      def login_page_link
        self[:login_page_link] || RailsConnector::LinkList.new(nil)
      end

      def login_page_link?
        login_page_link.present?
      end

      def login_page
        login_page_link.destination_objects.first
      end
    end
  end
end