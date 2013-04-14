class BlogCell < Cell::Rails
  helper :cms

  # Cell actions:

  def entries(blog, entries)
    @blog = blog
    @entries = entries

    render(format: params[:format]) # html, rss
  end

  def entry_details(entry)
    @blog = entry.blog
    @entry = entry

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

  def entry(entry)
    @entry = entry

    render
  end

  # The following states assume that @blog and @entry are given.

  def comment
    if @entry.enable_comments? && @entry.disqus_shortname.present?
      render
    end
  end

  def gravatar
    @author = @entry.author

    if @author
      render
    end
  end

  def published_at
    @date = @entry.valid_from.to_date

    render
  end

  def published_by
    @author = @entry.author

    if @author
      render
    end
  end

  def snippet
    render
  end
end