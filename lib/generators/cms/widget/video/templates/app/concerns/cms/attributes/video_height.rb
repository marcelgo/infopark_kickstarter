module Cms
  module Attributes
    # This is a string attribute concern. It should be included via +include
    # Cms::Attributes::VideoHeight+ in all CMS models that use this attribute.
    module VideoHeight
      def video_height
        return self[:video_height] if self[:video_height].present?

        ratio(video_width)
      end

      private

      def ratio(width)
        if video.present?
          if video.width.present? && video.height.present?
            return width * video.height / video.width
          end
        end

        width / 3 * 2
      end
    end
  end
end