class Blog < Obj
  include Page

  include Cms::Attributes::Headline
  include Cms::Attributes::DisqusShortname
  include Cms::Attributes::Description

  def blog
    self
  end

  def latest_entries
    # TODO Currently only the published workspace is searchable.
    RailsConnector::Workspace.find('published').as_current do
      BlogEntry.all.
        and(:_path, :starts_with, path + '/').
        batch_size(100).
        order(:_valid_from).
        reverse_order.
        take(10)
    end
  end
end