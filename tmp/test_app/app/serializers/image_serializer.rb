class ImageSerializer < ActiveModel::Serializer
  attributes :id, :path

  def path
    "/#{id}"
  end
end