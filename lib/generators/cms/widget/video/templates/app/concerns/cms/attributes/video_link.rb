module Cms
  module Attributes
    # This is a linklist attribute concern. It should be included via +include
    # Cms::Attributes::VideoLink+ in all CMS models that use this attribute.
    module VideoLink
      def video_link
        self[:video_link] || RailsConnector::LinkList.new(nil)
      end

      def video_link?
        video_link.present?
      end

      def first_video_link
        video_link.first
      end
    end
  end
end