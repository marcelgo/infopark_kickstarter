class Column3Widget < Obj
  cms_attribute :column_1, type: :widget
  cms_attribute :column_2, type: :widget
  cms_attribute :column_3, type: :widget
  cms_attribute :column_1_width, type: :string, default: '4'
  cms_attribute :column_2_width, type: :string, default: '4'
  cms_attribute :column_3_width, type: :string, default: '4'

  # Most CMS objects are either a page or a box. In order for them to
  # have common behavior, uncomment one of the following lines.
  # include Page
  include Widget
end