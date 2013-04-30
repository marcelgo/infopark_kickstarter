class Blog < Obj
  include Page

  cms_attribute :headline, type: :string
  cms_attribute :show_in_navigation, type: :boolean
  cms_attribute :sort_key, type: :string
  cms_attribute :disqus_shortname, type: :string
  cms_attribute :description, type: :text

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