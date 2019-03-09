class CreateReferrals < ActiveRecord::Migration[5.2]
  def change
    create_table :referrals do |t|
      t.references :user, foreign_key: true
      t.string :friend_email
      t.date :date
      t.boolean :accepted

      t.timestamps
    end
  end
end
