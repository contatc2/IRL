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
    # if create comes from new path
    @invitation = FriendInvitation.new
    @invitation.friend = User.find(params[:friend_id])
    @invitation.user_id = current_user.id
    if @invitation.save
      redirect_to user_path(@user)
    else
      render :new
    end
    # if create comes from referral path
    @invitation = FriendInvitation.new
    @invitation.friend = current_user.id
    @referral = Referral.where(friend_email: current_user.email)
    @invitation.user = @referral.user
    @invitation.save
    redirect_to user_path(current_user) #TBC - should it be search?
  end

  def update
    @invitation = FriendInvitation.find(params[:id])
    @invitation.update(invitation_params)
    redirect_to user_path(current_user)
  end

  private

  def set_user
    @user = current_user
  end

  def invitation_params
    params.require(:friend_invitation).permit(:enter_email, :friend_id, :accepted, :id)
  end
end
