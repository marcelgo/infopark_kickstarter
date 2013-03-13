module Cms
  module Attributes
    # This is a linklist attribute concern. It should be included via +include
    # Cms::Attributes::<%= class_name %>+ in all CMS models that use this attribute.
    module <%= class_name %>
      def <%= method_name %>
        self[:<%= file_name %>] || <%= preset_value %>
      end

      def <%= method_name %>?
        <%= method_name %>.present?
      end

      <%- if max_size == 1 -%>
      def first_<%= method_name %>
        <%= method_name %>.destination_objects.first
      end
      <%- end -%>
    end
  end
end