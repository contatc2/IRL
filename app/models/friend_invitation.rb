class FriendInvitation < ApplicationRecord
  belongs_to :user
  belongs_to :friend, class_name: 'User', foreign_key: 'friend_id'

  validates :friend, presence: true, uniqueness: { scope: :user,
  message: "you can only invite a user once" }
end
