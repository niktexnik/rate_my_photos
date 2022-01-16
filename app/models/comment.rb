class Comment < ApplicationRecord
  belongs_to :commentable, polymorphic: true, counter_cache: true
  belongs_to :user

  validates :body, presence: true, length: { minimum: 1 }
end
