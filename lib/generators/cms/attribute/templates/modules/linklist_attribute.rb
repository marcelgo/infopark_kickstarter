module Cms
  module Attributes
    # This is a linklist attribute concern. It should be included via +include
    # Cms::Attributes::<%= class_name %>+ in all CMS models that use this attribute.
    module <%= class_name %>
      def <%= file_name %>
        self[:<%= file_name %>] || RailsConnector::LinkList.new(nil)
      end

      def <%= file_name %>?
        <%= file_name %>.present?
      end

      <%- if max_size == 1 -%>
      def first_<%= file_name %>
        <%= file_name %>.destination_objects.first
      end
      <%- end -%>
    end
  end
end