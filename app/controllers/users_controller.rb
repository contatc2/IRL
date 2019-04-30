class UsersController < ApplicationController
  before_action :find_user, only: %i[show edit update]
  def index
    @users = User.all
  end

  def show
    @invitations = FriendInvitation.where(friend: @user, accepted: nil)
    @accepted_invitations = FriendInvitation.where(accepted: true, user: @user).or(FriendInvitation.where(accepted: true, friend: @user))
    @pending_invitations = FriendInvitation.where(accepted: nil, user: @user)
    @matches = Match.where(match_one: @user).or(Match.where(match_two: @user)).reject { |match| match.status == "Rejected" }
    @pseudo_matches = PseudoMatch.where(match_one: @user)
    @helper_matches = Match.where(helper: @user)
    @helper_pseudo_matches = PseudoMatch.where(helper: @user)
    if @accepted_invitations.empty? && @pending_invitations.empty? && @invitations.empty?
      redirect_to new_friend_invitation_path
    end
  end

  def edit
  end

  def update
    @user.update(user_params)
    if @user.available && @user.adjective_1.nil?
      redirect_to edit_user_path(@user)
    else
      redirect_to user_path(@user)
    end
  end

  def single_or_not
    @user = current_user
  end

  private

  def find_user
    @user = User.find(params[:id])
  end

  def user_params
    params.require(:user).permit(:adjective_1, :adjective_2, :adjective_3, :male_search, :female_search, :available)
  end
end
