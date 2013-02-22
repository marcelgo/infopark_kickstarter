module Cms
  module Attributes
    module GoogleMapsAddress
      def google_maps_address_attribute
        :google_maps_address
      end

      def default_google_maps_address
        ''
      ensure
        Cms::Errors::MissingAttribute.notify(self, __FILE__)
      end

      def google_maps_address
        self[google_maps_address_attribute].presence || default_google_maps_address
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