class Book < ActiveRecord::Base
  belongs_to :user

  obfuscate_id

  validates :title, presence: true, on: :create
  validates :title, uniqueness: true

  has_attached_file :image,
    storage: :dropbox,
    styles: { medium: "300x300!", thumb: "100x100!", icon: "50x50!" },
    default_url: "https://encrypted-tbn1.gstatic.com/images?q=tbn:ANd9GcSo8uPVFZTL8nxsBIPhyBw9DxZ0lbyS4hqMpQxQU4wYu0gaFDe34q-UhsHr",
    dropbox_credentials: Rails.root.join("#{Rails.root}/config/dropbox.yml"),
    dropbox_options: { path: proc { |style| "files/books/user_#{user_id}/#{id}/image/#{image.original_filename}" } },
    unique_filename: true 
  validates_attachment_content_type :image, content_type: ["image/jpg", "image/jpeg", "image/png", "image/gif"]

  has_attached_file :pdf,
    storage: :dropbox,
    dropbox_credentials: Rails.root.join("#{Rails.root}/config/dropbox.yml"),
    dropbox_options: { path: proc { |style| "files/books/user_#{user_id}/#{id}/pdf/#{pdf.original_filename}" } },
    unique_filename: true 
  validates_attachment_content_type :pdf, content_type: ["application/pdf"]
  validates_attachment :pdf, presence: true

  before_save :format_attributes

  def self.search(attrb, query)
    where("#{attrb} like ?", "%#{query}%") 
  end

  private
  def format_attributes
    self.title.downcase!
    self.authors.downcase!
    self.description.downcase!
    self.categories.downcase!
    self.publisher.downcase!
  end
end
