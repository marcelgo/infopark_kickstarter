class Container < Obj
  include Cms::Attributes::ShowInNavigation

  def page
    parent.page
  end
end