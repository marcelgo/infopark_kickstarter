class MediabrowserController < ApplicationController
  def index
    images = RailsConnector::Workspace.default.as_current do
      Image.all.to_a
    end

    page = (params[:page].presence || 1).to_i
    limit = (params[:limit].presence || 10).to_i
    start_index = (page - 1) * limit
    end_index = start_index + limit - 1
    resultCount = 111
    maxPages = 3

    images = images[start_index..end_index] || []

    render json: images, meta: {resultCount: resultCount, maxPages: maxPages}, each_serializer: ImageSerializer, root: 'images'
  end

  def edit
    @obj = Obj.find(params[:id])

    markup = begin
      render_to_string(@obj.mediabrowser_edit_view_path, layout: false)
    rescue ActionView::MissingTemplate => error
      render_to_string('obj/edit', layout: false)
    end

    render json: {
      markup: markup
    }
  end
end