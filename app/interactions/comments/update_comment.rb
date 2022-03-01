class UpdateComment < ActiveInteraction::Base
  object :comment
  string :body

  validates :body, presence: true, unless: -> { body.nil? }

  def execute

    #prams = {"a" => 'xxx', "b" => 'yyy', "c" => nil}
    #keys = %w[a, b, c]
    #result = params.select{|key| key.in?(keys) && key.present?}

    comment.body = body if body.present?

    errors.merge!(comment.errors) unless comment.save

    comment
  end
end
