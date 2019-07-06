class Friendship < ApplicationRecord
  belongs_to :friend_one, class_name: 'User'
  belongs_to :friend_two, class_name: 'User'

  validates :friend_one_id, presence: true
  validates :friend_two_id, presence: true
end
