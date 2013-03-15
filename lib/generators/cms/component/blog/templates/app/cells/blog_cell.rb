class BlogCell < Cell::Rails
  include RailsConnector::DefaultCmsRoutingHelper
  helper :blog

  def show(blog, entries)
    @blog = blog
    @entries = entries

    render
  end

  def search(blog, entries, search_word)
    @blog = blog
    @entries = entries
    @search_word = search_word

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

  def disqus_snippet(blog)
    @disqus_shortname = blog.disqus_shortname

    render
  end

end