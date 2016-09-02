#
class SorceryCore < ActiveRecord::Migration
  def change
    add_column :users, :crypted_password, :string
    add_column :users, :salt, :string

    add_index :users, :email, unique: true

    remove_column :users, :password
    remove_column :users, :login
  end
end
