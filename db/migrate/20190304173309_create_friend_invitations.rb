class CreateFriendInvitations < ActiveRecord::Migration[5.2]
  def change
    create_table :friend_invitations do |t|
      t.boolean :accepted
      t.references :friend, index: true, foreign_key: { to_table: :users}
      t.references :user, index: true, foreign_key: { to_table: :users}

      t.timestamps
    end
  end
end
