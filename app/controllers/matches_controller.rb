class MatchesController < ApplicationController
  before_action :find_match, only: %i[show update]

  def show
  end

  def new
    @match = Match.new
    @match_one = User.find(params[:match_one])
    @friends = current_user.friends.where(available: true)
    @referral = Referral.new
  end

  def create
    @match = Match.new(match_params)
    @match.helper = current_user
    @match.match_two = User.find(params[:match][:match_two])
    UserMailer.match_created(@match.match_one, @match.match_two, @match.helper).deliver_now
    @match.save
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
