module Photos
  class Create < ActiveInteraction::Base
    file :image
    object :user
    string :name, :description

    validates :image, :name, :description, presence: true

    def execute
      errors.merge!(photo.errors) unless photo = Photo.create(inputs)
      photo
    end
  end
end
