class Api::V1::UsersController < Api::V1::BaseController
  acts_as_token_authentication_handler_for User
  before_action :set_user, only: %i[show update]
  def index
    @users = policy_scope(User)
  end

  def show
  end

  def update
    if @user.update(user_params)
      render :show
    else
      render_error
    end
  end

  private

  def set_user
    @user = User.find(params[:id])
    authorize @user
  end

  def user_params
    params.require(:user).permit(:adjective_1, :adjective_2, :adjective_3, :male_search, :female_search, :available)
  end

  def render_error
    render json: { errors: @user.errors.full_messages },
      status: :unprocessable_entity
  end
end
