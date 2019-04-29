class Referral < ApplicationRecord
  belongs_to :user
  validates :friend_email, presence: true, uniqueness: { scope: :user,
    message: "you can only invite an email once" }
end
