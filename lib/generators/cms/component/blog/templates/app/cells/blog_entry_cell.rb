class BlogEntryCell < Cell::Rails
  helper :cms
  helper :blog

  def preview(entry)
    @entry = entry

    render
  end

  def show(entry)
    @entry = entry
    @blog = entry.blog

    render
  end

  def header(entry)
    @entry = entry

    render
  end

  def facebook(entry)
    @entry = entry

    if @entry.enable_facebook_button?
      render
    end
  end

  def twitter(entry)
    @entry = entry

    if @entry.enable_twitter_button?
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

  def preview_box(entry)
    @box = entry.boxes.first
    @entry = entry

    render_preview_box(@box.class.to_s)
  rescue ActionView::MissingTemplate
    render_preview_box('box_missing')
  end

  def comment(entry)
    @entry = entry

    if @entry.enable_disqus_comments? && @entry.disqus_shortname.present?
      render
    end
  end

  private

  def render_preview_box(name)
    render(view: "previews/#{name.underscore}")
  end
end