# This class represents the Ruby on Rails model equivialent to a CMS object class.
class ErrorPage < Obj
  # Includes behavior common to all CMS pages.
  include Page

  include Cms::Attributes::ShowInNavigation

  # Overrides #show_in_navigation from Cms::Attributes::ShowInNavigation.
  def show_in_navigation?
    false
  end
end