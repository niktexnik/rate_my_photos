class Photo < ApplicationRecord
  # include AASM
  include Commentable
  mount_uploader :image, ImageUploader
  validates :name, presence: true
  belongs_to :user
  belongs_to :competition, optional: true

  # AASM conf
  # aasm do
  #   state :pending, initial: true
  #   state :completed
  #   state :rejected
  # end
  # event :stage do
  #   transitions from: :pending, to: :completed
  # end

  # event :stage do
  #   transitions from: :pending, to: :rejected
  # end
end
