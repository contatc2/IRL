class MatchesController < ApplicationController
  before_action :find_match, only: :update

  def show
  end

  def new
    @match = Match.new
    @pseudo_match = PseudoMatch.new
    @match_one = User.find(params[:match_one])
    single_friends = current_user.friends.select(&:available)
    single_friends_invited = FriendInvitation.where(accepted: nil, user: current_user)
    .map(&:friend)&.select(&:available)
    @friends = single_friends_invited + single_friends
    @referral = Referral.new
  end

  def create
    @match = Match.new(match_params)
    @match.helper = current_user
    @match.match_two = User.find(params[:match][:match_two_id])
    @match.save
    UserMailer.match_created(@match.match_one, @match.helper, @match.intro_message).deliver_now
    UserMailer.match_created(@match.match_two, @match.helper, @match.intro_message).deliver_now
    redirect_to user_path(current_user)
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
