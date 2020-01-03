class User < ActiveRecord::Base
  validates :username, uniqueness: { case_sensitive: false,
    message: "Username taken." }
  validates :username, format: { with: /\A[a-zA-Z0-9]+([._]?[a-zA-Z0-9]+)*\z/,
    message: "Invalid username. Please try again." }
  validates :email, uniqueness: { case_sensitive: false,
    message: "There is an account with this email."  }

  has_secure_password
  has_many :wishlists
end
