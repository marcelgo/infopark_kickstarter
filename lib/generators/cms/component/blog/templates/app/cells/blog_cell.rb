class BlogCell < Cell::Rails
  include RailsConnector::DefaultCmsRoutingHelper
  helper :blog

  def show(blog, entries)
    @blog = blog
    @entries = entries

    render
  end

  def sidebar(blog)
    @blog = blog

    render
  end

  def search_sidebar(blog)
    @blog = blog

    render
  end

  def tag_sidebar(blog)
    @blog = blog

    render
  end
end