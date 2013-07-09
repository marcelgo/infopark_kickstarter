module ApplicationHelper
  # Extracts controller and current object information to pass them on to
  # JavaScript via html class and data attributes.
  def body_attributes(obj)
    attributes = {
      class: params[:controller],
    }

    if obj
      attributes[:data] = {
        current_obj_path: obj.path,
      }
    end

    attributes
  end

  def image_url(image)
    request.protocol + request.host_with_port + image_path(image)
  end
end