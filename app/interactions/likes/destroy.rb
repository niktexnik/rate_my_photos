module Likes
  class Destroy < ActiveInteraction::Base
    object :like

    def execute
      like.destroy
    end
  end
end
