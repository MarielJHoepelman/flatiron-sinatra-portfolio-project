class RemoveDescriptionFromWishLists < ActiveRecord::Migration[6.0]
  def change
    remove_column :wish_lists, :description
  end
end
