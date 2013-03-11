module Cms
  module Attributes
    module GalleryAutoplay
      def gallery_autoplay
        self[:gallery_autoplay].to_s
      end

      def gallery_autoplay?
      	gallery_autoplay == 'Yes'
      end
    end
  end
end