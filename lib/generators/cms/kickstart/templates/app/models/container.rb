class Container < Obj
  include Cms::Attributes::Headline
  include Cms::Attributes::ShowInNavigation

  def page
    parent.page
  end
end