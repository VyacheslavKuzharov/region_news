module Api::V1
  class NewsLightSerializer < ActiveModel::Serializer
    attributes :id, :title
  end
end