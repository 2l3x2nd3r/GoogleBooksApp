class User < ActiveRecord::Base
  # External resources definitions
  authenticates_with_sorcery!

  # Virtual Attributes
  attr_accessor :password, :password_confirmation

  # Validations
  has_many :books

  validates :username, :email, :password, presence: true, on: :create
  validates :username, uniqueness: true
  validates :email, uniqueness: true, format: { with: /\A[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,4}\z/, message: "must be a valid email" }

  validates :password, length: { minimum: 3 }, on: :create
  validates :password, confirmation: true, on: :create

  has_attached_file :avatar,
    storage: :dropbox,
    styles: { medium: "300x300>", thumb: "100x100>", icon: "50x50" },
    default_url: "https://en.opensuse.org/images/0/0b/Icon-user.png",
    dropbox_credentials: Rails.root.join("#{Rails.root}/config/dropbox.yml"),
    dropbox_options: { path: proc { |style| "files/avatars/#{id}/#{avatar.original_filename}" } },
    unique_filename: true 
  validates_attachment_content_type :avatar, content_type: ["image/jpg", "image/jpeg", "image/png", "image/gif"]

  # Callbacks
  before_save :format_attributes

  # Methods
  private
  def format_attributes
    self.email.downcase!
  end
end
