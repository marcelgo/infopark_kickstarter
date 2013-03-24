class BlogController < CmsController
  def index
    @entries = @obj.latest_entries

    respond_to do |format|
      format.html { @entries }
      format.rss { @entries }
    end
  end
end