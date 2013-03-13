module Cms
  module Attributes
    # This is a date attribute concern. It should be included via +include
    # Cms::Attributes::<%= class_name %>+ in all CMS models that use this attribute.
    module <%= class_name %>
      def <%= method_name %>
        self[:<%= file_name %>] || <%= preset_value %>
      end
    end
  end
end