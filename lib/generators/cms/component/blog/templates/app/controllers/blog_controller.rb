class BlogController < CmsController
  layout 'blog'

  def index
    @blog = @obj

    if params[:tag].nil?
      @entries = @obj.entries
    else
      @entries = @obj.entries_by_tag(params[:tag])
    end

    respond_to do |format|
      format.html { @entries }
      format.any(:atom, :rss) { @entries }
    end
  end
end