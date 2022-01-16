class Photo < ApplicationRecord
  include AASM
  include Commentable
  paginates_per 4
  mount_uploader :image, ImageUploader
  validates :name, :description, :image, presence: true
  belongs_to :user
  has_many :likes, dependent: :destroy

  # AASM config
  aasm do
    state :pending, initial: true
    state :published
    state :rejected

    event :stage do
      transitions from: :pending, to: :published
    end
    event :stage do
      transitions from: :pending, to: :rejected
    end
  end

  scope :published, -> { where(aasm_state: 'published') }
end
