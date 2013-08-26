class Redirect < Obj
  cms_attribute :show_in_navigation, type: :boolean
  cms_attribute :sort_key, type: :string
  cms_attribute :redirect_link, type: :linklist, max_size: 1

  # Most CMS objects are either a page or a box. In order for them to
  # have common behavior, uncomment one of the following lines.
  include Page
  # include Widget
end