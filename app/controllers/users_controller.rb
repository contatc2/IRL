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

  def update
    @user = User.find(params[:id])
    @user.update(user_params)
    user_adjectives = params[:user][:user_adjectives]
    @useradjs = UserAdjective.new(adjective: user_adjectives[:adjective], adjective_2: user_adjectives[:adjective_2], adjective_3: user_adjectives[:adjective_3])
    @useradjs.save
    redirect_to user_path(@user)
  end

  def share
    email = params[:email]
    UserMailer.share(email, current_user).deliver_now
  end


  private

  def user_params
    params.require(:user).permit(:picture, :user_adjectives)
    # params.require(:user).permit(:adjective, :adjective_2, :adjective_3)
    # params.require([:user][:user_adjectives]).permit(:adjective, :adjective_2, :adjective_3)
  end
end
