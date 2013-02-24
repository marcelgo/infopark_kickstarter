module Cms
  module Attributes
    module <%= class_name %>
      def <%= file_name %>_attribute
        :<%= file_name %>
      end

      def default_<%= file_name %>
        ''
      ensure
        Cms::Errors::MissingAttribute.notify(self, __FILE__)
      end

      def <%= file_name %>
        self[<%= file_name %>_attribute] || default_<%= file_name %>
      end

      def <%= file_name %>?
        <%= file_name %> == 'Yes'
      end
    end
  end
end