class Photo < ApplicationRecord
  include Commentable
  mount_uploader :image, ImageUploader
  validates :name, presence: true
  belongs_to :user
  belongs_to :competition
end
