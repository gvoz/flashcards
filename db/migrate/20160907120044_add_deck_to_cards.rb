# add reference Cards and Decks
class AddDeckToCards < ActiveRecord::Migration[5.0]
  def change
    add_reference :cards, :deck, foreign_key: true
    remove_reference :cards, :user
  end
end
