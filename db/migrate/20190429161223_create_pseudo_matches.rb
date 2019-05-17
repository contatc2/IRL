class CreatePseudoMatches < ActiveRecord::Migration[5.2]
  def change
    create_table :pseudo_matches do |t|
      t.references :helper, index: true, foreign_key: { to_table: :users}
      t.references :match_one, index: true, foreign_key: { to_table: :users}
      t.text :intro_message
      t.string :match_two_email
      t.string :match_two_first_name
      t.string :match_two_picture
      t.boolean :match_one_accepted
      t.date :date

      t.timestamps
    end
  end
end
