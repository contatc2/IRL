class CreateFriendships < ActiveRecord::Migration[5.2]
  def change
    create_table :friendships do |t|
      t.references :friend_one, foreign_key: { to_table: :users}, index: { unique: true}
      t.references :friend_two, foreign_key: { to_table: :users}, index: { unique: true}

      t.timestamps
    end
  end
end
