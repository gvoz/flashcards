class AddColumnsToCards < ActiveRecord::Migration[5.0]
  def change
    add_column :cards, :review_interval, :float, default: 0
    add_column :cards, :number_of_mistakes, :integer, default: 0
  end
end
