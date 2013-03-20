class BlogCell < Cell::Rails
  include RailsConnector::DefaultCmsRoutingHelper
  helper :blog

  def show(blog, entries)
    @blog = blog
    @entries = entries

    render
  end

  def search(blog, entries, query)
    @blog = blog
    @entries = entries
    @query = query

    render
  end

  def sidebar(blog, entry = nil)
    @blog = blog
    @entry = entry

    render
  end

  def search_sidebar(blog)
    @blog = blog

    render
  end

  def tag_sidebar(blog, entry)
    @blog = blog
    @tags = blog.tags
    @active_tags = entry.try(:tags) || []

    render
  end
end