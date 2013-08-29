class ErrorPage < Obj
  cms_attribute :headline, type: :string
  cms_attribute :show_in_navigation, type: :boolean

  include Page

  # Overrides #show_in_navigation from Cms::Attributes::ShowInNavigation.
  def show_in_navigation?
    false
  end
end