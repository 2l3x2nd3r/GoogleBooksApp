class User < ActiveRecord::Base
  # External resources definitions
  authenticates_with_sorcery!

  # Virtual Attributes
  attr_accessor :password, :password_confirmation

  # Validations
  validates :username, :email, :password, presence: true, on: :create
  validates :username, uniqueness: true
  validates :email, uniqueness: true, format: { with: /\A[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,4}\z/, message: "must be a valid email" }

  validates :password, length: { minimum: 3 }, on: :create
  validates :password, confirmation: true, on: :create

  # Callbacks
  before_save :format_attributes

  # Methods
  private
  def format_attributes
    self.email.downcase!
  end
end
