class BlogCell < Cell::Rails
  helper :cms

  # Cell actions:

  def posts(blog, posts)
    @blog = blog
    @posts = posts

    render(format: params[:format]) # html, rss
  end

  def post_details(post)
    @blog = post.blog
    @post = post

    render
  end

  def discovery(obj)
    if obj.respond_to?(:blog)
      @blog = obj.blog

      render
    end
  end

  # Cell states:
  # The following states assume that @blog is given.

  def post(post)
    @post = post

    render
  end

  # The following states assume that @blog and @post are given.

  def comment
    if @post.enable_comments? && @post.disqus_shortname.present?
      render
    end
  end

  def gravatar
    @author = @post.author

    if @author
      render
    end
  end

  def published_at
    @date = @post.valid_from.to_date

    render
  end

  def published_by
    @author = @post.author

    if @author
      render
    end
  end

  def snippet
    render
  end
end