class Friendship < ApplicationRecord
  belongs_to :friend_one, class_name: 'User', foreign_key: 'friend_one_id'
  belongs_to :friend_two, class_name: 'User', foreign_key: 'friend_two_id'
  belongs_to :friend_invitation
end
