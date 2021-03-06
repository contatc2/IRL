class User < ApplicationRecord
  include PgSearch
  after_create :send_welcome_email
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
    :recoverable, :rememberable, :validatable
  devise :omniauthable, omniauth_providers: [:facebook]
  acts_as_token_authenticatable
  has_many :matches, foreign_key: 'helper_id', dependent: :delete_all
  has_many :pseudo_matches, foreign_key: 'helper_id', dependent: :delete_all
  has_many :referrals, dependent: :delete_all
  has_many :friend_invitations, dependent: :delete_all
  has_many :friendships, foreign_key: 'friend_one_id'
  has_many :friend_twos, through: :friendships, source: :friend_two
  has_many :reverse_friendships, class_name: 'Friendship', foreign_key: 'friend_two_id'
  has_many :friend_ones, through: :reverse_friendships, source: :friend_one
  has_many :messages, dependent: :delete_all
  has_many :chat_rooms_one, foreign_key: 'user_one_id', dependent: :delete_all
  has_many :chat_rooms_two, foreign_key: 'user_two_id', dependent: :delete_all
  mount_uploader :picture, PhotoUploader
  pg_search_scope :search_by_name_and_email,
    against: %i[first_name last_name email],
  using: {
    tsearch: { prefix: true }
  }

  def self.find_for_facebook_oauth(auth)
    user_params = auth.slice(:provider, :uid)
    user_params.merge! auth.info.slice('email', 'first_name', 'last_name')
    user_params[:facebook_picture_url] = auth.info.image
    user_params[:token] = auth.credentials.token
    user_params[:token_expiry] = Time.at(auth.credentials.expires_at)
    user_params = user_params.to_h

    user = User.find_by(provider: auth.provider, uid: auth.uid)
    user ||= User.find_by(email: auth.info.email) # User did a regular sign up in the past.
    if user
      user.update(user_params)
    else
      user = User.new(user_params)
      user.password = Devise.friendly_token[0, 20] # Fake password for validation
      user.save
    end

    return user
  end

  def full_name
    "#{first_name.capitalize} #{last_name.capitalize}"
  end

  def first_name_cap
    first_name.capitalize
  end

  def friends
    friend_ones + friend_twos
  end

  def search
    adjective_1.present? ? "#{gender_search}, #{adjective_1}, #{adjective_2} & #{adjective_3}" : gender_search
  end

  def gender_search
    if male_search && female_search
      'a man or a woman'
    elsif male_search
      'a man'
    else
      'a woman'
    end
  end

  def status
    if available
      'single'
    else
      'helper'
    end
  end

  def profile_image_tag
    if picture.present?
      picture.url
    elsif facebook_picture_url.present?
      facebook_picture_url
    else
      'https://images.pexels.com/photos/459880/pexels-photo-459880.jpeg?auto=compress&cs=tinysrgb&dpr=2&h=750&w=1260'
    end
  end

  def profile_image_path
    if picture.present?
      picture
    elsif facebook_picture_url.present?
      facebook_picture_url
    else
      'https://images.pexels.com/photos/459880/pexels-photo-459880.jpeg?auto=compress&cs=tinysrgb&dpr=2&h=750&w=1260'
    end
  end

  private

  def send_welcome_email
    UserMailer.welcome_email(self).deliver_now
  end
end
