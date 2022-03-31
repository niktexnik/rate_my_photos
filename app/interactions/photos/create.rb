module Photos
  class Create < ActiveInteraction::Base
    file :image
    object :user
    string :name, :description

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
end
