class FriendInvitationsController < ApplicationController
  def new
    @invitation = FriendInvitation.new
    @user = User.find(params[:user_id])
  end

  def create
    @invitation = FriendInvitation.new
    @user = User.find(params[:user_id])
  end

  def update
  end
end
