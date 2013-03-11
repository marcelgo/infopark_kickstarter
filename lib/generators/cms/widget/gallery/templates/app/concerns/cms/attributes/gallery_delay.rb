module Cms
  module Attributes
    module GalleryDelay
      def gallery_delay
        self[:gallery_delay] || ''
      end
    end
  end
end