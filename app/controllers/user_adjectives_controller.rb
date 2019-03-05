class UserAdjectivesController < ApplicationController
  def index
  end

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

  def useradj_params
    params.require(:user_adjective).permit(:adjective)
  end
end
