class WishList < ActiveRecord::Base
  belongs_to :user
  has_many :wishes

  def is_own_list?(session_user_id)
    user_id == session_user_id
  end
end
