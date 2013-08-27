class Column2Widget < Obj
  cms_attribute :column_1, type: :widget
  cms_attribute :column_2, type: :widget
  cms_attribute :column_1_width, type: :string, default: '6'
  cms_attribute :column_2_width, type: :string, default: '6'

  # Most CMS objects are either a page or a box. In order for them to
  # have common behavior, uncomment one of the following lines.
  # include Page
  include Widget
end