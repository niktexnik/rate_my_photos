module Comments
  class Create < ActiveInteraction::Base
    set_callback :type_check, :before do
      find_commentable
    end

    object :user, class: User
    string :body
    integer :photo_id, :comment_id, :parent_id, default: nil

    validates :body, presence: true

    def execute
      puts "!!!!!!!!Comment_id!!!!!!!!#{inputs}"
      puts "!!!!!!!!Comment_id!!!!!!!!#{comment_id}"
      puts "!!!!!!!!Photo_id!!!!!!!!#{photo_id}"
      puts "!!!!!!!!Commentaable2!!!!!!!!#{@commentable}"

      comment = @commentable.comments.build(body: body, user: user, commentable: @commentable,
                                            photo_id: photo_id, parent_id: parent_id)
      if comment.valid?
        NotificationsChannel.broadcast_to(
          @commentable.user,
          title: 'You have a new comment from user:',
          body: "#{comment.user.name} text: #{comment.body}, Total: #{Photo.find(photo_id).comments_count}"
        )
      end
      errors.merge!(comment.errors) unless comment.save

      comment
    end

    def find_commentable
      @commentable =
        if inputs[:comment_id].present?
          Comment.find(inputs[:comment_id])
        elsif inputs[:photo_id].present?
          Photo.find(inputs[:photo_id])
        end
      puts "!!!!!!!!Commentaable1!!!!!!!!#{@commentable}"
    end
  end
end
