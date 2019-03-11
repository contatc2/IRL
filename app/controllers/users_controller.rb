class UsersController < ApplicationController
  before_action :find_user, only: %i[show update]
  def index
    @users = User.all
  end

  def show
    @invitations = FriendInvitation.where(friend: @user, accepted: nil)
    @accepted_invitations = FriendInvitation.where(accepted: true, user: @user).or(FriendInvitation.where(accepted: true, friend: @user))
    @pending_invitations = FriendInvitation.where(accepted: nil, user: @user)
    @matches = Match.where(match_one: @user).or(Match.where(match_two: @user))
    @helper_matches = Match.where(helper: @user)
  end

  def update
    user_adjectives = params[:user][:user_adjectives]
    if @user.user_adjectives.blank?
      @user.update(user_params)
      @useradjs = UserAdjective.new(adjective: user_adjectives[:adjective], adjective_2: user_adjectives[:adjective_2], adjective_3: user_adjectives[:adjective_3])
      @useradjs.user = @user
      @useradjs.save
    else
      @user.update(user_params)
      @useradjs = @user.user_adjectives
      @useradjs.update(adjective: user_adjectives[:adjective], adjective_2: user_adjectives[:adjective_2], adjective_3: user_adjectives[:adjective_3])
    end

    redirect_to user_path(@user)
  end

  private

  def find_user
    @user = User.find(params[:id])
  end

  def user_params
    params.require(:user).permit(:user_adjectives, :male_search, :female_search)
  end
end
