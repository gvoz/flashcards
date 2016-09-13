# Add locale for User
class AddLanguageToUser < ActiveRecord::Migration[5.0]
  def change
    add_column :users, :language, :string, default: 'ru'
  end
end
