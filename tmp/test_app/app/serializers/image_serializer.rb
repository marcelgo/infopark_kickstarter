class ImageSerializer < ActiveModel::Serializer
  attributes :id, :body_data_url, :title
end