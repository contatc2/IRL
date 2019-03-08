class MatchesController < ApplicationController
  before_action :find_match, only: %i[show update]

  def show
  end

  def new
    @match = Match.new
    @match_one = User.find(params[:match_one])
    @friends = current_user.friends
  end

  def create
    @match = Match.new(match_params)
    @match.helper = current_user
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
    params.require(:match).permit(:match_one_id, :match_two_id, :match_one_accepted, :match_two_accepted)
  end
end
