class FollowersDatum < ApplicationRecord
  belongs_to :instagram_user
  validates :count, presence: true
end
