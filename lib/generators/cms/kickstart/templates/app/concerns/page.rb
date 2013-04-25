# This concern provides behavior that all CMS pages have in common. It is
# similar to a +Widget+, as it allows to add behavior by composition instead of
# inheritance.
module Page
  def page
    self
  end

  # Overriden method +toclist+ from +RailsConnector::BasicObj+.
  #
  # Sorts toclist objects by their sort key and only selects Page objects that
  # should be displayed in the navigation.
  def toclist
    super.select { |obj| obj.is_a?(Page) && obj.show_in_navigation? }.sort_by { |obj| obj.sort_key.to_s }
  end
end