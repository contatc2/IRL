class UserAdjective < ApplicationRecord
  belongs_to :user
  validates :adjective, presence: true, :allow_blank => false
  validates :adjective_2, presence: true, :allow_blank => false
  validates :adjective_3, presence: true, :allow_blank => false
end
