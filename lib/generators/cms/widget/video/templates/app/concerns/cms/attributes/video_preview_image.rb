module Cms
  module Attributes
    # This is a linklist attribute concern. It should be included via +include
    # Cms::Attributes::VideoPreviewImage+ in all CMS models that use this attribute.
    module VideoPreviewImage
      def video_preview_image
        self[:video_preview_image] || RailsConnector::LinkList.new(nil)
      end

      def video_preview_image?
        video_preview_image.present?
      end

      def first_video_preview_image
        video_preview_image.first
      end
    end
  end
end