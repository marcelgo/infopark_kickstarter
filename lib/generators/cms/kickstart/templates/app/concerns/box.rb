# This concern provides behavior that all CMS boxes have in common. It is
# similar to a +Page+, as it allows to add behavior by composition instead of
# inheritance.
module Box
  # Determines the page where the box is embedded.
  def page
    parent.page
  end
end