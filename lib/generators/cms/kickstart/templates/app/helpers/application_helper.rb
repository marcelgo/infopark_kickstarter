module ApplicationHelper
  def body_attributes
    {
      class: [
        params[:controller],
      ],
      data: {
        current_obj_path: @obj.path,
      },
    }
  end

  def image_url(image)
    request.protocol + request.host_with_port + image_path(image)
  end
end