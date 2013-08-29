class TeaserWidget < Obj
  cms_attribute :headline, type: :string
  cms_attribute :content, type: :html
  cms_attribute :link_to, type: :linklist, max_size: 1

  # Most CMS objects are either a page or a box. In order for them to
  # have common behavior, uncomment one of the following lines.
  # include Page
  include Widget
end