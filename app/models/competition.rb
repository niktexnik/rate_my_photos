class Competition < ApplicationRecord
  has_many :photos, dependent: :destroy
end
