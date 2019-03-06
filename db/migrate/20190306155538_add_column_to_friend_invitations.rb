class AddColumnToFriendInvitations < ActiveRecord::Migration[5.2]
  def change
    add_column :friend_invitations, :enter_email, :string
  end
end
