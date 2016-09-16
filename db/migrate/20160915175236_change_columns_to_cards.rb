# Change columns for SuperMemo
class ChangeColumnsToCards < ActiveRecord::Migration[5.0]
  def change
    remove_column :cards, :number_of_mistakes
    add_column :cards, :efactor, :float, default: 2.5
    add_column :cards, :repeat, :integer, default: 0
  end
end
