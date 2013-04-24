class Container < Obj
  include Cms::Attributes::ShowInNavigation
  include Cms::Attributes::SortKey

  def page
    parent.page
  end
end