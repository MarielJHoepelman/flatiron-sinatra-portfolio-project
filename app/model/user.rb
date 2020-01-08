class User < ActiveRecord::Base
  validates :username, presence: { message: "Username field cannot be blank." }
  validates :username, uniqueness: { case_sensitive: false,
    message: "Username taken." }
  validates :username, format: { with: /\A[a-zA-Z0-9]+([._]?[a-zA-Z0-9]+)*\z/i,
    message: "Invalid username. Please try again." }

  validates :email, presence: { message: "Email field cannot be blank." }
  validates :email, uniqueness: { case_sensitive: false,
    message: "There is an account with this email."  }
  validates :email, format: { with: /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z]+)*\.[a-z]+\z/i,
      message: "Invalid email format. Please try again." }
  validates :password_digest, presence: { message: "Password field cannot be blank." }    

  has_secure_password
  has_many :wishlists
end
