module Cms
  module Attributes
    module GalleryImages
      def gallery_images_attribute
        :gallery_images
      end

      def gallery_images
        self[gallery_images_attribute]
      end

      def gallery_images?
        gallery_images.present?
      end

    end
  end
end