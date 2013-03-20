require 'will_paginate/array'

class BlogController < CmsController
  layout 'blog'

  before_filter :set_blog_object

  def index
    entries = if params[:tag].present?
      search_service.search_by_tag(params[:tag])
    else
      search_service.search_all
    end

    @entries = paginate_entries(entries)

    respond_to do |format|
      format.html { @entries }
      format.any(:atom, :rss) { @entries }
    end
  end

  def search
    @query = params[:query]

    entries = search_service.search(@query)
    @entries = paginate_entries(entries)
  end

  private

  def set_blog_object
    @blog = if @obj.is_a?(::Blog)
      @obj
    else
      blog_id = params[:id] || params[:blog_id]

      Obj.find(blog_id)
    end
  end

  def paginate_entries(entries)
    entries.paginate(page: params[:page], per_page: 30)
  end

  def search_service
    BlogSearchService.new(@blog)
  end
end