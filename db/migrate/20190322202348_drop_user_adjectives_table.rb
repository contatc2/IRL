class DropUserAdjectivesTable < ActiveRecord::Migration[5.2]
  def up
    drop_table :user_adjectives
  end

  def down
    fail ActiveRecord::IrreversibleMigration
  end
end
