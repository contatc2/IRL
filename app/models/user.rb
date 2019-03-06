class User < ApplicationRecord
  after_create :send_welcome_email
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  has_many :matches
  has_many :friend_invitations, dependent: :destroy
  has_many :user_adjectives, dependent: :destroy
  mount_uploader :picture, PhotoUploader

  def full_name
    "#{first_name} #{last_name}"
  end

  private

  def send_welcome_email
    UserMailer.welcome_email(self).deliver_now
  end
end
