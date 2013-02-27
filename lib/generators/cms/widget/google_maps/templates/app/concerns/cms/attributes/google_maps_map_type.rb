module Cms
  module Attributes
    module GoogleMapsMapType
      def google_maps_map_type
        self[:google_maps_map_type] || 'ROADMAP'
      end
    end
  end
end