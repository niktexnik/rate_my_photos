# == Schema Information
#
# Table name: photos
#
#  id               :bigint           not null, primary key
#  comments_count   :integer          default(0), not null
#  description      :text             not null
#  image            :string
#  image_new        :string
#  likes_count      :integer          default(0), not null
#  moderated_date   :date
#  name             :string           not null
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
  mount_uploader :image_new, ImageUploader

  belongs_to :user
  has_many :likes, dependent: :destroy

  validates :name, :description, :image, presence: true

  scope :published, -> { where(status: :published) }
  scope :pending, -> { where(status: :pending) }
  scope :rejected, -> { where(status: :rejected) }
  scope :ordered_by, (lambda do |field_name, direction|
    return unless field_name.to_s.in?(column_names) && direction.to_s.downcase.in?(%w[asc desc])

    order(field_name => direction)
  end)

  scope :filter_by, ->(search) { where('name ILIKE :search or description ILIKE :search', search: "%#{search}%") }

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
