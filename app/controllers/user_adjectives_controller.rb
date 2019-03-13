class UserAdjectivesController < ApplicationController
  before_action :set_user
  before_action :find_user_adjectives, only: %i[edit update]
  def new
    @useradj = UserAdjective.new
  end

  # def create
  #   @useradj = UserAdjective.new(useradj_params)
  #   @useradj.user = @user
  #   @useradj.save
  #   redirect_to user_path(@user)
  # end

  def edit
  end

  # def update
  #   if @useradj.update(useradj_params)
  #     redirect_to user_path(@user)
  #   else
  #     render :edit
  #   end
  # end

  private

  def set_user
    @user = User.find(params[:user_id])
  end

  def find_user_adjectives
    @useradj = UserAdjective.find(params[:id])
  end

  def useradj_params
    params.require(:user_adjective).permit(:adjective, :adjective_2, :adjective_3)
  end
end
