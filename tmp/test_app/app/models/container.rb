class Container < Obj
  cms_attribute :headline, type: :string
  cms_attribute :show_in_navigation, type: :boolean
  cms_attribute :sort_key, type: :string

  def page
    parent.page
  end
end