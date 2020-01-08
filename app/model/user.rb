class User < ActiveRecord::Base
  validates :name, presence: { message: "Name field cannot be blank." }

  validates :email, presence: { message: "Email field cannot be blank." }
  validates :email, uniqueness: { case_sensitive: false,
    message: "There is an account with this email."  }
  validates :email, format: { with: /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z]+)*\.[a-z]+\z/i,
      message: "Invalid email format. Please try again." }

  validates :password_digest, presence: { message: "Password field cannot be blank." }

  has_secure_password
  has_many :wishlists
end
