class User < ActiveRecord::Base
  # External resources definitions
  authenticates_with_sorcery!

  obfuscate_id spin: 120318
   # Virtual Attributes
  attr_accessor :password, :password_confirmation

  # Validations
  validates :username, :email, :password, presence: true
  validates :username, uniqueness: true
  validates :email, uniqueness: true, format: { with: /\b[A-Z0-9._%a-z\-]+@(gmail|hotmail|yahoo|live)\.com\z/, message: "must be a valid email" }
  validates :password, length: { minimum: 3 }, confirmation: true  

  # Callbacks
  before_save :format_attributes

  # Methods
  private
  def format_attributes
    self.email.downcase!
    self.username.downcase!
  end
end
