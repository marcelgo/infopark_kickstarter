class ContactPage < Obj
  cms_attribute :headline, type: :string
  cms_attribute :content, type: :html
  cms_attribute :crm_activity_type, type: :string
  cms_attribute :show_in_navigation, type: :boolean
  cms_attribute :sort_key, type: :string

  # Most CMS objects are either a page or a box. In order for them to
  # have common behavior, uncomment one of the following lines.
  include Page
  # include Widget
end