class AddIndexToReferrals < ActiveRecord::Migration[5.2]
  def change
    add_index :referrals, :friend_email
  end
end
