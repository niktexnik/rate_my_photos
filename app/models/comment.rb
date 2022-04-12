# == Schema Information
#
# Table name: comments
#
#  id               :bigint           not null, primary key
#  body             :string           not null
#  commentable_type :string           not null
#  created_at       :datetime         not null
#  updated_at       :datetime         not null
#  commentable_id   :bigint           not null
#  parent_id        :integer
#  photo_id         :bigint           not null
#  user_id          :bigint           not null
#
# Indexes
#
#  index_comments_on_commentable  (commentable_type,commentable_id)
#  index_comments_on_user_id      (user_id)
#
# Foreign Keys
#
#  fk_rails_...  (user_id => users.id)
#
class Comment < ApplicationRecord
  include Commentable

  paginates_per Rails.application.credentials.kaminari.dig(:comment_pagination)

  belongs_to :commentable, polymorphic: true
  belongs_to :user
  belongs_to :photo
  belongs_to :parent, class_name: 'Comment', optional: true

  has_many :replies, class_name: 'Comment', foreign_key: :parent_id, dependent: :destroy

  after_create do
    Photo.increment_counter(:comments_count, photo_id)
  end

  after_destroy do
    Photo.decrement_counter(:comments_count, photo_id)
  end

  validates :body, presence: true, length: { minimum: 1, maximum: 4000 }
end
