class AddColumnsToPseudoMatches < ActiveRecord::Migration[5.2]
  def change
    add_column :pseudo_matches, :match_two_facebook, :string
    add_column :pseudo_matches, :match_two_linkedin, :string
    add_column :pseudo_matches, :match_two_last_name, :string
  end
end
