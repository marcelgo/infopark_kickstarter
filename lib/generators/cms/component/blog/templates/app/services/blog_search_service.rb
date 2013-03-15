class BlogSearchService

  DEFAULT_WORKSPACE = 'published'

  def search(blog, word, workspace = DEFAULT_WORKSPACE)
    results = []

    results += search_title(blog, word, workspace)
    results += search_body(blog, word, workspace)


    results.inject([]) do |entries, entry|
      page = entry.page
      entries << page unless entries.include?(page)

      entries
    end
  end

  def search_title(blog, word, workspace = DEFAULT_WORKSPACE)
    results = []

    RailsConnector::Workspace.find(workspace).as_current do
      results =
        Obj.where(:_path, :starts_with, blog.path)
        .and(:title, :contains, word)
        .to_a
    end

    results
  end

  def search_body(blog, word, workspace = DEFAULT_WORKSPACE)
    results = []

    RailsConnector::Workspace.find(workspace).as_current do
      results =
        Obj.where(:_path, :starts_with, blog.path)
        .and(:body, :contains, word)
        .to_a
    end

    results
  end
end