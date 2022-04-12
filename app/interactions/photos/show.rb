module Photos
  class Show < ActiveInteraction::Base
    integer :id

    def execute
      photo = Photo.find(id)

      photo || errors.add(:id, 'does not exist')
    end
  end
end
