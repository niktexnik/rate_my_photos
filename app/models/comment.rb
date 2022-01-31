# == Schema Information
#
# Table name: comments
#
#  id               :bigint           not null, primary key
#  body             :string
#  commentable_type :string           not null
#  created_at       :datetime         not null
#  updated_at       :datetime         not null
#  commentable_id   :bigint           not null
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

  belongs_to :commentable, polymorphic: true
  belongs_to :user
  belongs_to :photo

  after_create do
    Photo.increment_counter(:comments_count, photo_id)
  end

  after_destroy do
    Photo.decrement_counter(:comments_count, photo_id)
  end

  # CommentNotification.with(photo: @photo).deliver_later(current_user)

  validates :body, presence: true, length: { minimum: 1, maximum: 4000 }
end
