class UsersController < ApplicationController
  def index
    @users = User.all
  end

  def show
    @user = User.find(params[:id])
    @invitations = FriendInvitation.where(friend: @user)
    @accepted_invitations = FriendInvitation.where(accepted: true, user: @user)
    @pending_invitations = FriendInvitation.where(accepted: nil, user: @user)
  end

end
