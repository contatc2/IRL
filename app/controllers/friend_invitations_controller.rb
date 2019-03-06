class FriendInvitationsController < ApplicationController
  before_action :set_user, only: %i[create update]
  def new
    @invitation = FriendInvitation.new
    UserMailer.creation_confirmation(@user).deliver_now
  end

  def create
    @invitation = FriendInvitation.new(invitation_params)
    @invitation.user = @user
    @invitation.save
    redirect_to user_path(@user)
  end

  def update
    @invitation = FriendInvitation.find(params[:id])
    @invitation.update(invitation_params)
    redirect_to user_path(current_user)
  end

  private

  def set_user
    @user = current_user
  end

  def invitation_params
    params.require(:friend_invitation).permit(:friend_id, :accepted)
  end
end
