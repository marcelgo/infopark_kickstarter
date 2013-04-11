module Cms
  module Attributes
    # This is a string attribute concern. It should be included via
    # +include Cms::Attributes::Address+
    # in all CMS models that use this attribute.
    module Address
      def address
        self[:address] || ''
      end

      def embed_url
        URI.escape("http://maps.google.de/maps?f=q&source=s_q&hl=de&geocode=&q=#{address}&ie=UTF8&t=m&z=14&output=embed").html_safe
      end
    end
  end
end