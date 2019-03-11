class ReferralsController < ApplicationController
  def create
    @referral = Referral.new(referral_params)
    @referral.user = current_user
    @referral.date = Date.today
    @referral.save
    @email = @referral.friend_email
    UserMailer.share(@email, current_user).deliver_now
  end

  def update
  end

  private

  def referral_params
    params.require(:referral).permit(:friend_email, :accepted)
  end
end
