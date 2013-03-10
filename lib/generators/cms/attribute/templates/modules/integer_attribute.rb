module Cms
  module Attributes
    # This is an integer attribute concern. It should be included via +include
    # Cms::Attributes::<%= class_name %>+ in all CMS models that use this attribute.
    module <%= class_name %>
      def <%= file_name %>
        (self[:<%= file_name %>] || 0).to_i
      end
    end
  end
end