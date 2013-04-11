module Cms
  module Attributes
    # This is a widget attribute concern. It should be included via
    # +include Cms::Attributes::<%= class_name %>+
    # in all CMS models that use this attribute.
    module <%= class_name %>
    end
  end
end