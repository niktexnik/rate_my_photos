class FindComment < ActiveInteraction::Base
  integer :id

  def execute
    comment = Comment.find_by_id(id)

    if comment
      comment
    else
      errors.add(:id, 'does not exist')
    end
  end
end
