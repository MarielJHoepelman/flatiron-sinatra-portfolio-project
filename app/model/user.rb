class User < ActiveRecord::Base
  validates :username, uniqueness: { case_sensitive: false }
  validates :email, uniqueness: { case_sensitive: false }

  has_secure_password
  has_many :wishlists
end
