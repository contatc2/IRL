class RemoveMatchFromMessages < ActiveRecord::Migration[5.2]
  def change
    remove_reference :messages, :match, foreign_key: true
    add_reference :messages, :chat_room, foreign_key: true
  end
end
