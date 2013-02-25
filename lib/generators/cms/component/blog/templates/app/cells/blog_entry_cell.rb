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

  def facebook(entry)
    @entry = entry

    render
  end

  def twitter(entry)
    @entry = entry

    render
  end
end