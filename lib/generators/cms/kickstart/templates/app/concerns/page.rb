# This concern provides behavior that all CMS pages have in common. It is
# similar to a +Widget+, as it allows to add behavior by composition instead of
# inheritance.
module Page
  def page
    self
  end
end