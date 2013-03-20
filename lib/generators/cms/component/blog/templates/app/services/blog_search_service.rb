class BlogSearchService
  attr_reader :blog

  def initialize(blog)
    @blog = blog
  end

  def search_all
    blog.entries
  end

  def search(query)
    results = search_field([:title, :body], query)

    results.inject([]) do |entries, entry|
      page = entry.page

      unless entries.include?(page)
        entries << page
      end

      entries
    end
  end

  def search_by_tag(tag)
    blog.entries.inject([]) do |entries, entry|
      if entry.tags.include?(tag)
        entries << entry
      end

      entries
    end
  end

  private

  def search_field(field, query)
    # TODO: Currently only the published workspace is searchable.
    RailsConnector::Workspace.find('published').as_current do
      Obj.where(:_path, :starts_with, blog.path).and(field, :contains, query).to_a
    end
  end
end