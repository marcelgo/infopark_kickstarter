module Cms
  module Attributes
    # This is an integer attribute concern. It should be included via +include
    # Cms::Attributes::VideoWidth+ in all CMS models that use this attribute.
    module VideoWidth
      def video_width
        (self[:video_width] || '660').to_i
      end
    end
  end
end