# Change review date from date to datetime
class ChangeTypeReviewDateInCards < ActiveRecord::Migration[5.0]
  def up
    change_table :cards do |t|
      t.change :review_date, :datetime
    end
  end

  def down
    change_table :cards do |t|
      t.change :review_date, :date
    end
  end
end
