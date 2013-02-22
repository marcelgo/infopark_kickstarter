module Cms
  module Attributes
    module Latitude
      def latitude_attribute
        :latitude
      end

      def default_latitude
        0.0
      ensure
        Cms::Errors::MissingAttribute.notify(self, __FILE__)
      end

      def latitude
        if self[latitude_attribute].present?
          self[latitude_attribute].to_f
        else
          default_latitude
        end
      end
    end
  end
end