class FriendInvitationsController < ApplicationController
  before_action :set_user, only: %i[new create]
  def new
    @invitation = FriendInvitation.new
  end

  def create
    @invitation = FriendInvitation.new(invitation_params)
    @invitation.user = @user
    @invitation.save
    redirect_to user_path(@user)
  end

  def update
  end

  private

  def set_user
    @user = User.find(params[:user_id])
  end

  def invitation_params
    params.require(:friend_invitation).permit(:friend_id, :accepted)
  end
end
