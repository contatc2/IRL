class AddGenderToUsers < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :male, :boolean
    add_column :users, :male_search, :boolean
    add_column :users, :female_search, :boolean
    remove_column :users, :gender_search
    remove_column :friend_invitations, :enter_email
  end
end
