class News < ApplicationRecord
  has_many :photos
  has_many :comments
  belongs_to :site
  belongs_to :city
  belongs_to :region
end
