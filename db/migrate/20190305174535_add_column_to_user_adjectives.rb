class AddColumnToUserAdjectives < ActiveRecord::Migration[5.2]
  def change
    add_column :user_adjectives, :adjective_2, :string
    add_column :user_adjectives, :adjective_3, :string
  end
end
