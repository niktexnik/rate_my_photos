class CreateComment < ActiveInteraction::Base
  object :user
  string :body
  # integer :current_user

  validates :body, presence: true

  def to_model
    Comment.new
  end

  def execute
    comment = Comment.new(inputs)
    comment.body = body

    errors.merge!(comment.errors) unless comment.save

    comment
  end
end
