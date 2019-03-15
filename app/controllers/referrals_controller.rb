class ReferralsController < ApplicationController
  skip_before_action :authenticate_user!, only: [:share]
  def create
    @referral = Referral.new(referral_params)
    @referral.user = current_user
    @referral.date = Date.today
    @referral.save
    @email = @referral.friend_email
    UserMailer.invite(@email, current_user).deliver_now
  end

  def update
  end

  def share
    @email = params[:referral][:friend_email]
    UserMailer.share(@email).deliver_now
    redirect_to new_friend_invitation_path
  end

  private

  def referral_params
    params.require(:referral).permit(:friend_email, :accepted)
  end
end
