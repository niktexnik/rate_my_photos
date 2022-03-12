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
class CommentSerializer < ApplicationSerializer
  attributes :id, :body
  
  belongs_to :photo
end
