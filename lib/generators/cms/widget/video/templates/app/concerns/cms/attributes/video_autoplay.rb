module Cms
  module Attributes
    module VideoAutoplay
      def video_autoplay
        self[:video_autoplay].to_s
      end

      def video_autoplay?
      	video_autoplay == 'Yes'
      end
    end
  end
end