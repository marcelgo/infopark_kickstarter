class BlogEntryCell < Cell::Rails
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

    render view: preview_name_for_box(@box)

  rescue ActionView::MissingTemplate
    render view: 'box_previews/box_missing_preview'
  end

  def comment(entry)
    @entry = entry

    if @entry.enable_disqus_comments?
      render
    end
  end

  private

  def preview_name_for_box(box)
    "box_previews/#{box.class.to_s.underscore}_preview"
  end
end