class UpdatePhoto < ActiveInteraction::Base
  object :photo

  string :image, :description, :name,
         default: nil

  validates :image,
            presence: true,
            unless: -> { image.nil? }
  validates :name,
            presence: true,
            unless: -> { name.nil? }
  validates :image,
            presence: true,
            unless: -> { image.nil? }

  def execute
    photo.image = image if image.present?
    photo.name = name if name.present?
    photo.description = description if description.present?

    errors.merge!(photo.errors) unless photo.save

    photo
  end
end
