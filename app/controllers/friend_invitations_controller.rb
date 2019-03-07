class FriendInvitationsController < ApplicationController
  before_action :set_user, only: %i[create update new share]

  def new
    @invitation = FriendInvitation.new
    if params[:query].present?
      sql_query = " users.email @@ :query"
      @searched_user = User.where(sql_query, query: "%#{params[:query]}%")
      # @test = User.where(first_name: params[:query])
    end
  end

  def create
    @invitation = FriendInvitation.new(invitation_params)
    @invitation.user_id = current_user.id
    if @invitation.save
      redirect_to user_path(@user)
    else
      render :new
    end
  end

  def update
    @invitation = FriendInvitation.find(params[:id])
    @invitation.update(invitation_params)
    redirect_to user_path(current_user)
  end

  def share
    @email = params[:friend_invitation][:enter_email]
    UserMailer.share(@email, current_user).deliver_now
  end
  # instead of def share put the content into create

  private

  def set_user
    @user = current_user
  end

  def invitation_params
    params.require(:friend_invitation).permit(:enter_email, :friend_id, :accepted)
  end
end
