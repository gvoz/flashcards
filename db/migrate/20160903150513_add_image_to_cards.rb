# Add colums for card's image
class AddImageToCards < ActiveRecord::Migration[5.0]
  def change
    add_column :cards, :image, :string
  end
end
