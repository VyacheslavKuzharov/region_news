class News < ApplicationRecord
  mount_uploader :image, ImageUploader

  has_many :photos
  # has_many :comments
  belongs_to :site
  belongs_to :city
  belongs_to :region
end
