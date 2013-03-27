class SearchPageController < CmsController
  def index
    @query = params[:q]
    @hits = []

    if @query.present?
      @hits = SearchRequest.new(@query, offset: 0, limit: 100).fetch_hits
      @hits = @hits.map { |hit| hit.obj.page }.compact.uniq
    else
      flash.now[:alert] = t('search.specify_query')
    end
  rescue Errno::ECONNREFUSED, Errno::EAFNOSUPPORT
    flash.now[:alert] = t('search.search_disabled')
  rescue RailsConnector::ClientError
    flash.now[:alert] = t('search.no_index')
  end
end