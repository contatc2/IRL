class AddConvertedToPseudoMatches < ActiveRecord::Migration[5.2]
  def change
    add_column :pseudo_matches, :converted, :boolean
  end
end
