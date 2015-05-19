class CreateBooks < ActiveRecord::Migration
  def change
    create_table :books do |t|
      t.integer :user_id
      t.string :title
      t.string :authors
      t.text :description
      t.string :categories
      t.string :isbn
      t.string :publisher
      t.datetime :published_date

      t.timestamps null: false
    end
    add_index :books, :user_id
  end
end
