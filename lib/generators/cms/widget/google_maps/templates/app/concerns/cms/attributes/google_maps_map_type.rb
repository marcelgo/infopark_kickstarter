module Cms
  module Attributes
    module GoogleMapsMapType
      def google_maps_map_type_attribute
        :google_maps_map_type
      end

      def default_google_maps_map_type
        'ROADMAP'
      ensure
        Cms::Errors::MissingAttribute.notify(self, __FILE__)
      end

      def google_maps_map_type
        self[google_maps_map_type_attribute] || default_google_maps_map_type
      end
    end
  end
end