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

  paginates_per Rails.application.credentials.kaminari.dig(:photo_pagination)

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


  # EVENTS_LIST = %i[reject approve]
  NOTIFICATIONS_HASH = {
    reject: {
      title: "Your photo was rejected",
      body: "Name: %{name}, description: %{description}",
      name: :name,
      description: :rejection_reason
    },
    approve: {
      title: "Your photo was approved",
      body: "Name: %{name}, description: %{description}",
      name: :name,
      description: :rejection_reason
    }
  }

  def send_notification_about(event)
    return if NOTIFICATIONS_HASH.keys.exclude?(event)

    NotificationsChannel.broadcast_to(
      NOTIFICATIONS_HASH.dig(event, :user).present? ? public_send(NOTIFICATIONS_HASH.dig(event, :user)) : user,
      title: NOTIFICATIONS_HASH.dig(event, :title),
      body: format(NOTIFICATIONS_HASH.dig(event, :body), 
                   name: public_send(NOTIFICATIONS_HASH.dig(event, :name)), 
                   description: public_send(NOTIFICATIONS_HASH.dig(event, :description))),
    )
  end

  # AASM config
  aasm column: :status do
    state :pending, initial: true
    state :published
    state :rejected
    state :removed

    event :aprove do
      transitions from: :pending, to: :published
      transitions from: :pending, to: :removed
    end

    event :reject do
      transitions from: :pending, to: :rejected
      transitions from: :published, to: :rejected
      transitions from: :rejected, to: :removed
    end

    event :remove do
      transitions from: :pending, to: :removed
      transitions from: :published, to: :removed
      transitions from: :rejected, to: :removed
    end

    event :revert do
      transitions from: :rejected, to: :pending
      transitions from: :published, to: :rejected
      transitions from: :removed, to: :pending
    end

    event :change do
      transitions from: :published, to: :pending
    end
  end
end
