class CreateLike < ActiveInteraction::Base
  object :like
  # integer :current_user

  validates :image, :name, :description, presence: true

  def to_model
    Photo.new
  end

  def execute
    photo = Photo.new(inputs)
    photo.user = user

    errors.merge!(photo.errors) unless photo.save

    photo
  end
end
