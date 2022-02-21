class UpdatePhoto < ActiveInteraction::Base
  object :photo
  string :description, :name

  puts "!!!!!!!!!! name: #{name}"

  validates :name, presence: true, unless: -> { name.nil? }
  validates :description, presence: true, unless: -> { description.nil? }

  def execute

    #prams = {"a" => 'xxx', "b" => 'yyy', "c" => nil}
    #keys = %w[a, b, c]
    #result = params.select{|key| key.in?(keys) && key.present?}

    photo.name = name if name.present?
    photo.description = description if description.present?

    errors.merge!(photo.errors) unless photo.save

    photo
  end
end
