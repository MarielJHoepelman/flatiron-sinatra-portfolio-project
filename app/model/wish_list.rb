class WishList < ActiveRecord::Base
  belongs_to :user
  has_many :wishes

  validates :name, presence: { message: "Name field cannot be blank." }

  def is_own_list?(session_user_id)
    user_id == session_user_id
  end
end
