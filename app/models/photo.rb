# == Schema Information
#
# Table name: photos
#
#  id               :bigint           not null, primary key
#  comments_count   :integer          default(0), not null
#  description      :text
#  image            :string
#  image_new        :string
#  likes_count      :integer          default(0), not null
#  moderated_date   :date
#  name             :string
#  rejection_reason :text
#  status           :string
#  created_at       :datetime         not null
#  updated_at       :datetime         not null
#  user_id          :bigint           not null
#
# Indexes
#
#  index_photos_on_user_id  (user_id)
#
# Foreign Keys
#
#  fk_rails_...  (user_id => users.id)
#
class Photo < ApplicationRecord
  include AASM
  include Commentable

  paginates_per 4

  mount_uploader :image, ImageUploader

  belongs_to :user
  has_many :likes, dependent: :destroy

  validates :name, :description, :image, presence: true

  # moderator
  scope :published, -> { where(status: :published) }
  scope :pending, -> { where(status: :pending) }
  scope :rejected, -> { where(status: :rejected) }

  # all users
  scope :ordered_by_likes_asc, -> { order(likes_count: :asc) }
  scope :ordered_by_likes_desc, -> { order(likes_count: :desc) }

  scope :ordered_by_comments_asc, -> { order(comments_count: :asc) }
  scope :ordered_by_comments_desc, -> { order(comments_count: :desc) }

  scope :ordered_by_date_asc, -> { order(created_at: :asc) }
  scope :ordered_by_date_desc, -> { order(created_at: :desc) }

  # AASM config
  aasm column: :status do
    state :pending, initial: true
    state :published
    state :rejected

    event :aprove do
      transitions from: :pending, to: :published
    end

    event :reject do
      transitions from: :pending, to: :rejected
    end

    event :revert do
      transitions from: :rejected, to: :pending
    end
  end
end
