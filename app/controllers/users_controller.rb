class UsersController < ApplicationController
  def index
    @users = User.all
  end

  def show
    @user = User.find(params[:id])
    @invitations = FriendInvitation.where(friend: @user, accepted: nil)
    @accepted_invitations = FriendInvitation.where(accepted: true, user: @user).or(FriendInvitation.where(accepted: true, friend: @user))
    @pending_invitations = FriendInvitation.where(accepted: nil, user: @user)
    @matches = Match.where(match_one: @user).or(Match.where(match_two: @user))
  end
end
