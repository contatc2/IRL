class CreateFriendships < ActiveRecord::Migration[5.2]
  def change
    create_table :friendships do |t|
      t.references :friend_one, foreign_key: { to_table: :users}
      t.references :friend_two, foreign_key: { to_table: :users}

      t.timestamps
    end
    add_index :friendships, [:friend_one_id, :friend_two_id], unique: true
  end
end
