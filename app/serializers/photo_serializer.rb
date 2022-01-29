# == Schema Information
#
# Table name: photos
#
#  id               :bigint           not null, primary key
#  comments_count   :integer          default(0), not null
#  description      :text
#  image            :string
#  image_new        :string
#  likes_count      :integer          default(0), not null
#  moderated_date   :date
#  name             :string
#  rejection_reason :text
#  status           :string
#  created_at       :datetime         not null
#  updated_at       :datetime         not null
#  user_id          :bigint           not null
#
# Indexes
#
#  index_photos_on_user_id  (user_id)
#
# Foreign Keys
#
#  fk_rails_...  (user_id => users.id)
#
class PhotoSerializer < ApplicationSerializer
  attributes :id, :name, :description, :image
  has_one :user
  has_many :comments
end
