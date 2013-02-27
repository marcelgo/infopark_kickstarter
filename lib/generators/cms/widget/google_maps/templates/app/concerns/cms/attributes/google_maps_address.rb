module Cms
  module Attributes
    module GoogleMapsAddress
      def google_maps_address
        self[:google_maps_address].to_s
      end

      def google_maps_address_bounds
        Geocoder.search(self.google_maps_address).first
      end

      def latitude
        google_maps_address_bounds.try(:latitude)
      end

      def longitude
        google_maps_address_bounds.try(:longitude)
      end
    end
  end
end