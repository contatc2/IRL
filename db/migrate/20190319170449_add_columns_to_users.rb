class AddColumnsToUsers < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :adjective_1, :string
    add_column :users, :adjective_2, :string
    add_column :users, :adjective_3, :string
  end
end
