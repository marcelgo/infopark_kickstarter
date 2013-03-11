module Cms
  module Attributes
    # This is a string attribute concern. It should be included via +include
    # Cms::Attributes::VideoHeight+ in all CMS models that use this attribute.
    module VideoHeight
      def video_height
        return self[:video_height] if self[:video_height].present?

        ratio(video_width)
      end

      def height
        video_height
      end

      private

      def ratio(width)
        if video.width.present? && video.height.present?
          width * video.height / video.width
        else
          width / 3 * 2
        end
      end
    end
  end
end