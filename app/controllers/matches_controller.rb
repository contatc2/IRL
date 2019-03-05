class MatchesController < ApplicationController
  before_action :set_user, only: %i[create update]
  def new
    @match = Match.new
  end

  def create
    @match = Match.new(match_params)
    @match.helper = @user
    @match.save
    redirect_to user_path(@match.match_one)
  end

  def update
    @match = Match.find(params[:id])
    @match.update(match_params)
    redirect_to user_path(current_user)
  end

  private

  def set_user
    @user = current_user
  end

  def match_params
    params.require(:match).permit(:match_one_id, :match_two_id, :match_one_accepted, :match_two_accepted)
  end
end
