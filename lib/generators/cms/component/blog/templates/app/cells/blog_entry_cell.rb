class BlogEntryCell < Cell::Rails
  helper :blog

  def preview(entry)
    @entry = entry

    render
  end

  def show(entry)
    @entry = entry

    render
  end

  def header(entry)
    @entry = entry

    render
  end

  def facebook(entry)
    @entry = entry

    if @entry.eneable_facebook_button?
      render
    end
  end

  def twitter(entry)
    @entry = entry

    if @entry.eneable_twitter_button?
      render
    end
  end

  def footer(entry)
    @entry = entry

    render
  end

  def preview_footer(entry)
    @entry = entry

    render
  end

  def comment(entry)
    @entry = entry

    if @entry.eneable_disqus_comments?
      render
    end
  end
end