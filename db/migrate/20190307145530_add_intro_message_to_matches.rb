class AddIntroMessageToMatches < ActiveRecord::Migration[5.2]
  def change
    add_column :matches, :intro_message, :text
  end
end
