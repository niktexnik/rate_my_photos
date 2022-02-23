class UpdateComment < ActiveInteraction::Base
  object :comment
  string :body

  puts "!!!!!!!!!! name: #{name}"

  validates :body, presence: true, unless: -> { name.nil? }

  def execute

    #prams = {"a" => 'xxx', "b" => 'yyy', "c" => nil}
    #keys = %w[a, b, c]
    #result = params.select{|key| key.in?(keys) && key.present?}

    photo.body = body if body.present?

    errors.merge!(photo.errors) unless photo.save

    photo
  end
end
