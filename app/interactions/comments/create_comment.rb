class CreateComment < ActiveInteraction::Base
  string :body
  object :user, class: User
  object :commentable

  validates :body, presence: true

  def execute
    comment = commentable.comments.create(body: body, user: user, photo: commentable)
    errors.merge!(comment.errors) unless comment.save

    comment
  end
end
