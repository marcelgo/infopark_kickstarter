class MediabrowserController < ApplicationController
  def index
    page = (params[:page].presence || 1).to_i
    limit = (params[:limit].presence || 10).to_i
    start_index = (page - 1) * limit
    end_index = start_index + limit - 1

    images, resultCount = RailsConnector::Workspace.default.as_current do
      query = Obj.where(:_obj_class, :equals, 'Image').offset(start_index).order('_last_changed').reverse_order
      [query.take(limit), query.count]
    end

    maxPages = (resultCount / limit.to_f).ceil

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