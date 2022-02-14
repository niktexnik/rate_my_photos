class DestroyPhoto < ActiveInteraction::Base
  object :photo

  def execute
    photo.destroy
  end
end
