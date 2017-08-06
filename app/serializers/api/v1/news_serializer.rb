module Api::V1
  class NewsSerializer < ActiveModel::Serializer
    attributes :id, :title, :description
  end
end