class <%= class_name %> < Obj
  <%- attributes.each do |attribute| -%>
  <%= "include Cms::Attributes::#{attribute.classify}" %>
  <%- end -%>

  # Most CMS objects are either a page, box or resource. In order for them to
  # have common behavior, uncomment one or more of the following lines.
  # include Page
  # include Box
  # include Resource
end