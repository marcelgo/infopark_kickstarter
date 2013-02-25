class BlogEntryController < CmsController
  layout 'blog'

  def index
    @entry = @obj
    @blog = @entry.blog
  end
end