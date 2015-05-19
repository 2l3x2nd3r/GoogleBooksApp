class AddAttachmentImagePdfToBooks < ActiveRecord::Migration
  def self.up
    change_table :books do |t|
      t.attachment :image
      t.attachment :pdf
    end
  end

  def self.down
    remove_attachment :books, :image
    remove_attachment :books, :pdf
  end
end
