class MediabrowserController < ApplicationController
  def index
    RailsConnector::Workspace.default.as_current do
      render json: Image.all.to_a, each_serializer: ImageSerializer, root: false
    end
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