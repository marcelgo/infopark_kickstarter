class SearchPageController < CmsController
  def index
    @query = params[:q] || ''
    @hits = SearchRequest.new(@query, offset: 0, limit: 100).fetch_hits

    @hits = @hits.map { |hit| hit.obj.page }.compact.uniq
  rescue RailsConnector::ClientError
    flash.now[:alert] = t('search.no_index')
  end
end