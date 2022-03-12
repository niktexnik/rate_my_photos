module Comments
  class Create < ActiveInteraction::Base
    string :body
    object :user, class: User
    object :commentable
    integer :photo_id

    validates :body, presence: true

    def execute
      puts "!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!#{photo_id}"
      puts "!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!#{body}"
      puts "!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!#{commentable}"
      puts "!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!#{user}"

      comment = commentable.comments.build(body: body, user: user, commentable: commentable, photo: photo_id)

      errors.merge!(comment.errors) unless comment.save

      comment
      puts "!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!#{comment.errors.messages}"
    end
  end
end

# comment = if commentable.is_a?(Photo)
#   commentable.comments.create(body: body, user: user, photo: commentable)
# else
#   commentable.comments.create(body: body, user: user, commentable: commentable.id, photo: photo.id)
# end
