module Comments
  class Show < ActiveInteraction::Base
    integer :id

    def execute
      comment = Comment.find_by_id(id)

      comment || errors.add(:id, 'does not exist')
    end
  end
end
