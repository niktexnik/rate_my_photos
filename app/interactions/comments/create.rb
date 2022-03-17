module Comments
  class Create < ActiveInteraction::Base
    string :body
    object :user, class: User
    object :commentable
    integer :photo_id

    validates :body, presence: true

    def execute
      comment = commentable.comments.build(body: body, user: user, commentable: commentable, photo_id: photo_id)

      errors.merge!(comment.errors) unless comment.save

      comment
    end
  end
end
