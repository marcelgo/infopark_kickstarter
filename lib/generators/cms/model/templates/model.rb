# This class represents the Ruby on Rails model equivialent to a CMS object class.
class <%= class_name %> < Obj
  # Most CMS objects are either a page or a widget. In order for them to have
  # common behavior, uncomment one of the following lines.
  # include Page
  # include Box

  <%- attributes.each do |attribute| -%>
  <%= "include Cms::Attributes::#{attribute.classify}" %>
  <%- end -%>
end