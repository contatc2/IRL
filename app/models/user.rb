class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable, :omniauthable, omniauth_providers: [:facebook]
  has_many :matches
  has_many :friend_invitations, dependent: :destroy
  has_many :user_adjectives, dependent: :destroy
  mount_uploader :picture, PhotoUploader

  def self.from_omniauth(auth)
    where(provider: auth.provider, uid: auth.uid).first_or_create! do |user|
      user.email = auth.info.email
      user.password = Devise.friendly_token[0, 20]
      user.first_name = auth.info.first_name
      user.picture = auth.info.image
    end
  end

  def full_name
    "#{first_name} #{last_name}"
  end
end
