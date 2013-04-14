module Cms
  module Attributes
    # This is a boolean attribute concern. It should be included via
    # +include Cms::Attributes::<%= class_name %>+
    # in all CMS models that use this attribute.
    module <%= class_name %>
      def <%= file_name %>
        self[:<%= file_name %>] || '<%= default %>'
      end

      def <%= file_name %>?
        <%= file_name %> == 'Yes'
      end
    end
  end
end