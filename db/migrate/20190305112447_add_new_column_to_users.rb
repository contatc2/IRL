class AddNewColumnToUsers < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :instagram_profile, :string
  end
end
