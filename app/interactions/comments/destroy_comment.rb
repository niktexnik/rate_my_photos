class DestroyComment < ActiveInteraction::Base
  object :comment

  def execute
    comment.destroy
  end
end
