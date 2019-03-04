class AddColumnToUsers < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :first_name, :string
    add_column :users, :last_name, :string
    add_column :users, :location, :string
    add_column :users, :date_of_birth, :date
    add_column :users, :picture, :string
    add_column :users, :facebook_profile, :string
    add_column :users, :twitter_profile, :string
    add_column :users, :linkedin_profile, :string
    add_column :users, :available, :boolean
  end
end
