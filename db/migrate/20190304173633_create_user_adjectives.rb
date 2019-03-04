class CreateUserAdjectives < ActiveRecord::Migration[5.2]
  def change
    create_table :user_adjectives do |t|
      t.string :adjective
      t.references :user, foreign_key: true

      t.timestamps
    end
  end
end
