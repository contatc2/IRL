class CreateMatches < ActiveRecord::Migration[5.2]
  def change
    create_table :matches do |t|
      t.boolean :match_one_accepted
      t.boolean :match_two_accepted
      t.references :helper, index: true, foreign_key: { to_table: :users}
      t.references :match_one, index: true, foreign_key: { to_table: :users}
      t.references :match_two, index: true, foreign_key: { to_table: :users}

      t.timestamps
    end
  end
end
