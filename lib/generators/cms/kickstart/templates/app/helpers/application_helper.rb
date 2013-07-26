module ApplicationHelper
  def body_attributes(obj)
    attributes = {}

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