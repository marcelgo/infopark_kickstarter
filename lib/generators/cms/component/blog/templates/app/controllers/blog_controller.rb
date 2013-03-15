class BlogController < CmsController
  layout 'blog'

  def index
    @blog = blog
    @entries = entries.paginate(page: params[:page])

    respond_to do |format|
      format.html { @entries }
      format.any(:atom, :rss) { @entries }
    end
  end

  def search
    @blog = blog
    @search_word = params[:search_word]
    search_service = BlogSearchService.new

    entries = search_service.search(@blog, params[:search_word])
    @entries = entries.paginate(page: params[:page])
  end

  private

  def blog
    if @obj === Blog
      blog ||= @obj
    else
      blog_id = params[:id] || params[:blog_id]
      blog ||= Obj.find(blog_id)
    end

    blog
  end

  def entries
    if params[:tag].nil?
      entries ||= blog.entries
    else
      entries ||= blog.entries_by_tag(params[:tag])
    end

    entries
  end
end