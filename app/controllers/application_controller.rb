class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  before_action :authenticate_user!
  before_action :configure_permitted_parameters, if: :devise_controller?

  def configure_permitted_parameters
    # For additional fields in app/views/devise/registrations/new.html.erb
    devise_parameter_sanitizer.permit(:sign_up, keys: [:available, :first_name, :last_name, :picture, :male, :date_of_birth])
    # For additional in app/views/devise/registrations/edit.html.erb
    devise_parameter_sanitizer.permit(:account_update, keys: [:first_name, :last_name, :location, :date_of_birth,
                                                              :picture, :available, :male, :facebook_profile,
                                                              :twitter_profile, :instagram_profile, :linkedin_profile])
  end

  def default_url_options
    { host: ENV["HOST"] || "localhost:3000" }
  end

  protected

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
      invitation = FriendInvitation.new(
        user: pseudo_match.helper,
        friend: resource
      )
      invitation.save
    end
  end
end
