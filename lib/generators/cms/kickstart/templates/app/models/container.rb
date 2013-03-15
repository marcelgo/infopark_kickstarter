class Container < Obj
  include Cms::Attributes::ShowInNavigation

  def page
    if parent
      parent.page
    end
  end
end