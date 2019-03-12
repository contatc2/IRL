class User < ApplicationRecord
  after_create :send_welcome_email
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  devise :omniauthable, omniauth_providers: [:facebook]
  has_many :matches
  has_many :referrals
  has_many :friend_invitations, dependent: :destroy
  has_many :friends, through: :friend_invitations
  has_many :user_adjectives, dependent: :destroy
  mount_uploader :picture, PhotoUploader
  # validates :gender_search, inclusion: { in: ('Man' 'Woman') }

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

  def gender_search
    if male_search && female_search
      'a man or a woman'
    elsif male_search
      'a man'
    else
      'a woman'
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
