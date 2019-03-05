class UsersController < ApplicationController
  def index
    @users = User.all
  end

  def show
    @user = User.find(params[:id])
    @friends = @user.friend_invitations.where(accepted: true)
    @friends_pending = @user.friend_invitations.where(accepted: nil)
  end
end
