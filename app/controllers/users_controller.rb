class UsersController < ApplicationController
  before_action :find_user, only: %i[show edit update show_helper show_single]
  before_action :define_friends_and_matches, only: %i[show show_helper show_single]
  def index
    @users = User.all
  end

  def show
    @message = Message.new
    redirect_to new_friend_invitation_path if @friends.empty? && @pending_user_invitations.empty? && @pending_friend_invitations.empty?
  end

  def show_helper
    respond_to do |format|
      format.html { render 'user/show' }
      format.js
    end
  end

  def show_single
    respond_to do |format|
      format.html { render 'user/show' }
      format.js
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

  def define_friends_and_matches
    @friends = @user.friends
    @single_friends = @friends.select(&:available)

    @pending_friend_invitations = FriendInvitation.where(friend: @user, accepted: nil)
    @pending_user_invitations = FriendInvitation.where(accepted: nil, user: @user)

    @matches = Match.where(match_one: @user).or(Match.where(match_two: @user)).reject { |match| match.status == "Rejected" }
    @pseudo_matches = PseudoMatch.where(match_one: @user, converted: nil)
    @helper_matches = Match.where(helper: @user)
    @helper_pseudo_matches = PseudoMatch.where(helper: @user, converted: nil)
  end

  def user_params
    params.require(:user).permit(:adjective_1, :adjective_2, :adjective_3, :male_search, :female_search, :available)
  end
end
