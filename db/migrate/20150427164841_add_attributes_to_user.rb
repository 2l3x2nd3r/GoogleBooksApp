class AddAttributesToUser < ActiveRecord::Migration
  def change
    add_column :users, :firstname, :string
    add_column :users, :lastname, :string
    add_column :users, :biography, :text
    add_column :users, :location, :string
  end
end
