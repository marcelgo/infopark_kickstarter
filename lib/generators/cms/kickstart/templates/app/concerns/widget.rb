# This concern provides behavior that all CMS widgets have in common. It is
# similar to a +Page+, as it allows to add behavior by composition instead of
# inheritance.
module Widget
  # Determines the page where the widget is embedded.
  def page
    id = self.path.split('/')[2]

    Obj.find(id)
  end
end