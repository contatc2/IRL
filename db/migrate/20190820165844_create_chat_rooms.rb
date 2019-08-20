class CreateChatRooms < ActiveRecord::Migration[5.2]
  def change
    create_table :chat_rooms do |t|
      t.references :user_one, foreign_key: { to_table: :users}
      t.references :user_two, foreign_key: { to_table: :users}

      t.timestamps
    end
    add_index :chat_rooms, [:user_one_id, :user_two_id], unique: true
  end
end
