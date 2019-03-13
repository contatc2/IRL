# frozen_string_literal: true

class Users::OmniauthCallbacksController < Devise::OmniauthCallbacksController
  # You should configure your model like this:
  # devise :omniauthable, omniauth_providers: [:twitter]

  # You should also create an action method in this controller like this:
  # def twitter
  # end
  def facebook
    user = User.find_for_facebook_oauth(request.env['omniauth.auth'])
    if user.persisted?
      sign_in_and_redirect user, event: :authentication
      # sign_in(user)
      # if user.available.nil?
      #   create_invitation(user) if Referral.where(friend_email: user.email).present?
      #   redirect_to single_or_not_users_path, notice: 'Signed in successfully.'
      # else
      #   redirect_to user_path(user), notice: 'Signed in successfully.'
      # end
      set_flash_message(:notice, :success, kind: 'Facebook') if is_navigational_format?
    else
      session['devise.facebook_data'] = request.env['omniauth.auth']
      redirect_to new_user_registration_url
    end
  end

  # More info at:
  # https://github.com/plataformatec/devise#omniauth

  # GET|POST /resource/auth/twitter
  # def passthru
  #   super
  # end

  # GET|POST /users/auth/twitter/callback
  # def failure
  #   super
  # end
  def failure
    redirect_to root_path
  end

  protected

  def create_invitation(resource)
    @referrals = Referral.where(friend_email: resource.email)
    @referrals.each do |referral|
      invitation = FriendInvitation.new
      invitation.user = referral.user
      invitation.friend = resource
      invitation.save
      referral.update(accepted: true)
    end
  end

  # The path used when OmniAuth fails
  # def after_omniauth_failure_path_for(scope)
  #   super(scope)
  # end
end
