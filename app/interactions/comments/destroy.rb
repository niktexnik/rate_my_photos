module Comments
  class Destroy < ActiveInteraction::Base
    object :comment

    def execute
      comment.destroy
    end
  end
end
