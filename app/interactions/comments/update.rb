module Comments
  class Update < ActiveInteraction::Base
    object :comment
    string :body

    validates :body, presence: true, unless: -> { body.nil? }

    def execute
      comment.body = body if body.present?

      errors.merge!(comment.errors) unless comment.save

      comment
    end
  end
end
