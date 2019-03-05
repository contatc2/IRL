class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  has_many :matches
  has_many :friend_invitations
  has_many :user_adjectives, dependent: :destroy
  mount_uploader :picture, PhotoUploader

  def full_name
    "#{first_name} #{last_name}"
  end
end
