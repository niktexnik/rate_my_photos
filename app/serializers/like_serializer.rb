class LikeSerializer < ApplicationSerializer
  attributes :id

  belongs_to :photo
end
