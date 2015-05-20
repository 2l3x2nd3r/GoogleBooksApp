class ChangeBooksPublishedDate < ActiveRecord::Migration
  def up
    change_table :books do |t|
      t.change :published_date, :date
    end
  end
end
