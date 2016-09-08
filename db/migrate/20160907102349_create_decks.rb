# create table decks
class CreateDecks < ActiveRecord::Migration[5.0]
  def change
    create_table :decks do |t|
      t.text :name
      t.text :description
      t.boolean :current, default: false
      t.references :user, foreign_key: true

      t.timestamps
    end
  end
end
