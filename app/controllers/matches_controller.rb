class MatchesController < ApplicationController
  before_action :find_match, only: :update

  def show
    @match = Match.includes(messages: :user).find(params[:id])
    @message = Message.new
  end

  def new
    @match = Match.new
    @match_one = User.find(params[:match_one])
    single_friends_invited = current_user.friends.where(available: true)
    single_friends_other = FriendInvitation.where(accepted: true, friend: current_user)
                                           .map(&:user)&.select { |user| user.available == true }
    @friends = single_friends_invited + single_friends_other
    @referral = Referral.new
  end

  def create
    @match = Match.new(match_params)
    @match.helper = current_user
    @match.match_two = User.find(params[:match][:match_two_id])
    @match.save
    UserMailer.match_created(@match.match_one, @match.helper, @match.intro_message).deliver_now
    UserMailer.match_created(@match.match_two, @match.helper, @match.intro_message).deliver_now
    redirect_to user_path(@match.match_one)
  end

  def update
    @match.update(match_params)
    redirect_to user_path(current_user)
  end

  private

  def find_match
    @match = Match.find(params[:id])
  end

  def match_params
    params.require(:match).permit(:match_one_id, :match_one_accepted, :match_two_accepted, :intro_message)
  end
end
