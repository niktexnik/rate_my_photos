module Photos
  class Update < ActiveInteraction::Base
    object :photo
    string :description, :name
    file :image, default: nil
    file :image_new, default: nil

    set_callback :validate, :before do
      check_transition
    end

    validates :name, presence: true
    validates :description, presence: true
    validates :image, presence: false
    validates :image_new, presence: false

    def execute
      photo.name = name
      photo.description = description
      if image_new.present?
        photo.image_new = image_new
        photo.status = 'pending'
      end
      errors.merge!(photo.errors) unless photo.save
      photo
    end

    def check_transition
      errors.add(photo.errors, 'action failed, transition error') unless photo.may_change?
    end
  end
end
