class PseudoMatchesController < ApplicationController
  before_action :find_match, only: %i[show update]

  def show
  end

  def create
    @pseudo_match = PseudoMatch.new(pseudo_match_params)
    @pseudo_match.helper = current_user
    @pseudo_match.date = Date.today
    @pseudo_match.save!
    UserMailer.match_created(@pseudo_match.match_one, @pseudo_match.helper, @pseudo_match.intro_message).deliver_now
    redirect_to user_path(current_user)
  end

  def update
    @pseudo_match.update(pseudo_match_params)
    params[:match_one_accepted] && UserMailer.match_invite(@pseudo_match.match_two_email, @pseudo_match.helper).deliver_now
    redirect_to user_path(current_user)
  end

  private

  def find_match
    @pseudo_match = PseudoMatch.find(params[:id])
  end

  def pseudo_match_params
    params.require(:pseudo_match).permit(:match_one_id, :match_one_accepted, :match_two_facebook, :match_two_linkedin,
                                         :match_two_first_name, :match_two_last_name, :match_two_email,
                                         :match_two_picture, :intro_message)
  end
end
