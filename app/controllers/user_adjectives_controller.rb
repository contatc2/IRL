class UserAdjectivesController < ApplicationController
  before_action :set_user
  def new
    @useradj = UserAdjective.new
  end

  def create
    @useradj = UserAdjective.new(useradj_params)
    @useradj.user = @user
    @useradj.save
    redirect_to user_path(@user)
  end

  private

  def set_user
    @user = User.find(params[:user_id])
  end

  def useradj_params
    params.require(:user_adjective).permit(:adjective, :adjective_2, :adjective_3)
  end
end
