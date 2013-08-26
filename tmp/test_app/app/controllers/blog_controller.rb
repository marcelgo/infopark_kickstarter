class BlogController < CmsController
  def index
    @posts = @obj.latest_posts

    respond_to do |format|
      format.html { @posts }
      format.rss { @posts }
    end
  end
end