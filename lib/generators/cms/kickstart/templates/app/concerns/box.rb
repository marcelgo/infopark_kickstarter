# This concern provides behavior that all CMS widgets have in common.
module Box
  def page
    if parent
      parent.page
    end
  end
end