module Photos
  class Update < ActiveInteraction::Base
    object :photo
    string :description, :name
    file :image, default: nil
    file :image_new, default: nil

    validates :name, presence: true, unless: -> { name.nil? }
    validates :description, presence: true, unless: -> { description.nil? }
    validates :image, presence: false
    validates :image_new, presence: false

    def execute
      # inputs.select { |key| key.in?(inputs.keys) && key.present? }
      photo.name = name if name.present?
      photo.description = description if description.present?
      if image_new.present?
        photo.image_new = image_new
        photo.change!
      end

      errors.merge!(photo.errors) unless photo.save

      photo
    end
  end
end
