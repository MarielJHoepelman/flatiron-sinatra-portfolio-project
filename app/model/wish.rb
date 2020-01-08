class Wish < ActiveRecord::Base
  validates :name, :description, :url, presence: { message: "Fields cannot be blank." }
  validates :url, format: { with: /\A(http|https):\/\/[a-z0-9]+([\-\.]{1}[a-z0-9]+)*\.[a-z]{2,5}(([0-9]{1,5})?\/.*)?\z/,
    message: "Invalid url. Please try again." }
  belongs_to :wishlist
end
