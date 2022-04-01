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
class PhotoSerializer < ApplicationSerializer
  attributes :id, :name, :description, :large_url, :thumb_url, :avatar_url, :likes_count, :likes
  attributes :comments, :comments_count

  def large_url
    object.image_url(:large)
  end

  def thumb_url
    object.image_url(:thumb)
  end

  def avatar_url
    object.image_url(:avatar)
  end

  def likes
    object.likes.map do |like|
      {
        like_id: like.id,
        user_id: like.user_id
      }
    end
  end

  def likes_count
    object.likes.count
  end

  def comments_count
    object.comments_count
  end

  def comments
    object.comments.map do |comment|
      comment_comments(comment)
    end
  end

  def comment_comments(comment)
    {
      user_id: comment.user_id,
      comment_id: comment.id,
      comment_body: comment.body,
      parent_id: comment.parent_id,
      comment_comments: comment.comments.map do |comment|
        comment_comments(comment)
      end
    }
  end
end
