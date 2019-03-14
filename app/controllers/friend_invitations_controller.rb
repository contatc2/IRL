class FriendInvitationsController < ApplicationController
  before_action :set_user, only: %i[create update new share]
  def new
    @invitation = FriendInvitation.new
    if params[:search].present?
      @names = params[:search][:query].split
      @searched_user = User.where("first_name ILIKE ? AND last_name ILIKE ?", @names[0], @names[1])
                           .or(User.where("first_name ILIKE ? AND last_name ILIKE ?", @names[1], @names[0]))
    end
    @referral = Referral.new
  end

  def create
    @invitation = FriendInvitation.new
    @invitation.friend = User.find(params[:friend_id])
    @invitation.user = current_user
    if @invitation.save
      redirect_to user_path(@user)
    else
      render :new
    end
  end

  def update
    @invitation = FriendInvitation.find(params[:id])
    @invitation.update(invitation_params)
    UserMailer.friend_acceptation(@invitation.user, current_user).deliver_now unless @invitation.accepted == false
    redirect_to user_path(current_user)
  end

  private

  def set_user
    @user = current_user
  end

  def invitation_params
    params.require(:friend_invitation).permit(:friend_id, :accepted)
  end
end
