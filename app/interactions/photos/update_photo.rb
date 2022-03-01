class UpdatePhoto < ActiveInteraction::Base
  object :photo
  string :description, :name
  file :image, default: nil
  file :image_new, default: nil

  validates :name, presence: true, unless: -> { name.nil? }
  validates :description, presence: true, unless: -> { description.nil? }
  validates :image, presence: false
  validates :image_new, presence: false

  def execute
    # prams = {"a" => 'xxx', "b" => 'yyy', "c" => nil}
    # keys = %w[a, b, c]
    # result = params.select{|key| key.in?(keys) && key.present?}

    photo.name = name if name.present?
    photo.description = description if description.present?
    photo.image = image if image.present?

    if image_new.present?
      photo.image_new = image_new
      photo.status = 'pending'
    end

    errors.merge!(photo.errors) unless photo.save

    photo
  end
end
