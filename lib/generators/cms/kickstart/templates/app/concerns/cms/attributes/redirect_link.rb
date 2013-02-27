module Cms
  module Attributes
    module RedirectLink
      def redirect_link
        self[:redirect_link] || RailsConnector::LinkList.new(nil)
      end

      def redirect_link?
        redirect_link.present?
      end

      def redirect
        redirect_link.destination_objects.first
      end
    end
  end
end