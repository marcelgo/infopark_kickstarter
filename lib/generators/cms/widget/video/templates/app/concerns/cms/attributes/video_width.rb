module Cms
  module Attributes
    module VideoWidth
      def video_width
        (self[:video_width] || '600').to_i
      end
    end
  end
end