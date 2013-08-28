class Website < Obj
  def homepage
    self.class.default_homepage
  end

  def homepages
    @homepages ||= toclist.select { |obj| obj.is_a?(Homepage) }
  end

  def website
    self
  end
end