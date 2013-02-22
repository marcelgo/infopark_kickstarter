module Cms
  module Attributes
    module Longitude
      def longitude_attribute
        :longitude
      end

      def default_longitude
        0.0
      ensure
        Cms::Errors::MissingAttribute.notify(self, __FILE__)
      end

      def longitude
        if self[longitude_attribute].present?
          self[longitude_attribute].to_f
        else
          default_longitude
        end
      end
    end
  end
end