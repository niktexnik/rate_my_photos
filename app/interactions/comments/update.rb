module Comments
  class Update < ActiveInteraction::Base
    object :comment
    string :body

    validates :body, presence: true

    def execute
      errors.merge!(comment.errors) unless comment.Update(body: body)

      comment
    end
  end
end
