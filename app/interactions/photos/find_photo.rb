class FindPhoto < ActiveInteraction::Base
  integer :id

  def execute
    photo = Photo.find_by_id(id)

    if photo
      photo
    else
      errors.add(:id, 'does not exist')
    end
  end
end
