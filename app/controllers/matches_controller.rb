class MatchesController < ApplicationController
  before_action :find_match, only: %i[update show]

  def show
  end

  def new
    @match = Match.new
    @pseudo_match = PseudoMatch.new
    @match_one = User.find(params[:match_one])
    single_friends = current_user.friends.select { |friend| friend.available && friend.male == @match_one.male_search }
    single_friends_invited = FriendInvitation.where(accepted: nil, user: current_user)
    .map(&:friend)&.select(&:available)
    @friends = single_friends_invited + single_friends
    @referral = Referral.new
  end

  def create
    @match = Match.new(match_params)
    @match.helper = current_user
    @match.match_two = User.find(params[:match][:match_two_id])
    if @match.save!
      @match.pseudo_match_id.nil? && UserMailer.match_created(@match.match_one, @match.helper, @match.intro_message).deliver_now
      redirect_to user_path(current_user)
    else
      render :new
    end
  end

  def update
    @match.update(match_params)
    params[:match][:match_one_accepted] && UserMailer.match_created(@match.match_two, @match.helper, @match.intro_message).deliver_now
    if @match.match_two_accepted
      UserMailer.match_accepted(@match.match_one, @match.match_two).deliver_now
      UserMailer.match_accepted(@match.match_two, @match.match_one).deliver_now
    end
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
