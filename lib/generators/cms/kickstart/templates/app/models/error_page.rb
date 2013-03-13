class ErrorPage < Obj
  include Cms::Attributes::ShowInNavigation

  include Page

  # Overrides #show_in_navigation from Cms::Attributes::ShowInNavigation.
  def show_in_navigation?
    false
  end
end