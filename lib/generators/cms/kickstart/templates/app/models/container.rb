class Container < Obj
  include Cms::Attributes::Headline
  include Cms::Attributes::ShowInNavigation
  include Cms::Attributes::SortKey

  def page
    parent.page
  end
end