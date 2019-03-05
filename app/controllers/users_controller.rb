class UsersController < ApplicationController
  def index
    @users = User.all
  end

  def show
    @user = User.find(params[:id])
    @friends = @user.friend_invitations.where(accepted: true)
    @friends_pending = @user.friend_invitations.where(accepted: nil)
  end

  def update
    @user = User.find(params[:id])
    @user.update(user_params)
    user_adjectives = params[:user][:user_adjectives]
    @useradjs = UserAdjective.new(adjective: user_adjectives[:adjective], adjective_2: user_adjectives[:adjective_2], adjective_3: user_adjectives[:adjective_3])
    @useradjs.save
    redirect_to user_path(@user)
  end


  private

  def user_params
    params.require(:user).permit(:picture, :user_adjectives)
    # params.require(:user).permit(:adjective, :adjective_2, :adjective_3)
    # params.require([:user][:user_adjectives]).permit(:adjective, :adjective_2, :adjective_3)
  end


end
