class AddPseudoMatchIdToMatches < ActiveRecord::Migration[5.2]
  def change
    add_reference :matches, :pseudo_match, foreign_key: false
  end
end
