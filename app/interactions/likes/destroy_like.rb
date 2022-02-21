class DestroyLike < ActiveInteraction::Base
  object :like

  def execute
    like.destroy
  end
end
