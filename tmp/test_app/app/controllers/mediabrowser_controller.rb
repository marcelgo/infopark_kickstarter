class MediabrowserController < ApplicationController
  def index
    RailsConnector::Workspace.default.as_current do
      render json: Image.all.to_a, each_serializer: ImageSerializer, root: false
    end
  end
end