class Wish < ActiveRecord::Base
  validates :name, :description, :url, presence: { message: "Fields cannot be blank." }
  belongs_to :wishlist
end
