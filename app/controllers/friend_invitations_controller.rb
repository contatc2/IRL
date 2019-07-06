class FriendInvitationsController < ApplicationController
  before_action :set_user, only: %i[create update new share]
  def new
    @invitation = FriendInvitation.new
    @search = params[:query]
    @friends = @user.friends
    @pending_invitations = FriendInvitation.where(accepted: nil, user: @user)
    @users_to_remove = @friends + @pending_invitations + [@user]
    @search_results = User.search_by_name_and_email(@search) if @search.present?
    @referral = Referral.new
  end

  def create
    @invitation = FriendInvitation.new
    @invitation.friend = User.find(params[:friend_id])
    @invitation.user = current_user
    if @invitation.save
      UserMailer.friend_invitation(current_user, @invitation.friend).deliver_now
      redirect_to user_path(@user), info: "You have invited #{@invitation.friend.first_name_cap}.<br>
      #{view_context.link_to('Add more friends', new_friend_invitation_path, class: 'alert-link')}.".html_safe
    else
      render :new
    end
  end

  def update
    @invitation = FriendInvitation.find(params[:id])
    @invitation.update(invitation_params)
    if @invitation.accepted
      UserMailer.friend_acceptation(@invitation.user, current_user).deliver_now
      Friendship.create(friend_one: @invitation.user, friend_two: @invitation.friend)
    end
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
