module Cms
  module Attributes
    # This is a linklist attribute concern. It should be included via +include
    # Cms::Attributes::VideoFile+ in all CMS models that use this attribute.
    module VideoFile
      def video_file
        self[:video_file] || RailsConnector::LinkList.new(nil)
      end

      def video_file?
        video_file.present?
      end

      def first_video_file
        video_file.first
      end
    end
  end
end