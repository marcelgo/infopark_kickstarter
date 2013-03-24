class <%= class_name %> < Obj
  <%- attributes.each do |attribute| -%>
  <%= "include Cms::Attributes::#{attribute.camelize}" %>
  <%- end -%>

  # Most CMS objects are either a page or a box. In order for them to
  # have common behavior, uncomment one of the following lines.
  # include Page
  # include Box
end