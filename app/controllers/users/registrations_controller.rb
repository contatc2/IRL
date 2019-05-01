# frozen_string_literal: true

class Users::RegistrationsController < Devise::RegistrationsController
  # before_action :configure_sign_up_params, only: [:create]
  # before_action :configure_account_update_params, only: [:update]

  # GET /resource/sign_up
  # def new
  #   super
  # end

  # POST /resource
  def create
    build_resource(sign_up_params)
    # raise
    resource.save
    yield resource if block_given?
    if resource.persisted?
      if resource.active_for_authentication?
        set_flash_message! :notice, :signed_up
        sign_up(resource_name, resource)
        create_invitation(resource) if Referral.where(friend_email: resource.email).present?
        respond_with resource, location: after_sign_up_path_for(resource)
      else
        set_flash_message! :notice, :"signed_up_but_#{resource.inactive_message}"
        expire_data_after_sign_in!
        respond_with resource, location: after_inactive_sign_up_path_for(resource)
      end
    else
      clean_up_passwords resource
      set_minimum_password_length
      respond_with resource
    end
  end

  # GET /resource/edit
  # def edit
  #   super
  # end

  # PUT /resource
  def update
    super
  end

  # DELETE /resource
  # def destroy
  #   super
  # end

  # GET /resource/cancel
  # Forces the session data which is usually expired after sign
  # in to be expired now. This is useful if the user wants to
  # cancel oauth signing in/up in the middle of the process,
  # removing all OAuth session data.
  # def cancel
  #   super
  # end

  protected

  def update_resource(resource, params)
    resource.update_without_password(params)
  end

  def after_update_path_for(resource)
    user_path(resource)
  end

  def create_invitation(resource)
    @referrals = Referral.where(friend_email: resource.email, accepted: nil)
    @referrals.each do |referral|
      invitation = FriendInvitation.new(
        user: referral.user,
        friend: resource
      )
      invitation.save
      referral.update(accepted: true)
    end
  end

  def create_match(resource)
    @pseudo_matches = PseudoMatch.where(match_two_email: resource.email, converted: nil)
    @pseudo_matches.each do |pseudo_match|
      match = Match.new(
        helper: pseudo_match.helper,
        match_one: pseudo_match.match_one,
        match_one_accepted: pseudo_match.match_one_accepted,
        match_two: resource,
        intro_message: pseudo_match.intro_message
      )
      match.save
      pseudo_match.update(converted: true)
    end
  end

  def after_sign_up_path_for(resource)
    if current_user.available
      edit_user_path(resource)
    else
      user_path(resource)
    end
  end
  # If you have extra params to permit, append them to the sanitizer.
  # def configure_sign_up_params
  #   devise_parameter_sanitizer.permit(:sign_up, keys: [:attribute])
  # end

  # If you have extra params to permit, append them to the sanitizer.
  # def configure_account_update_params
  #   devise_parameter_sanitizer.permit(:account_update, keys: [:attribute])
  # end

  # The path used after sign up.

  # The path used after sign up for inactive accounts.
  def after_inactive_sign_up_path_for(resource)
    super(resource)
  end
end
