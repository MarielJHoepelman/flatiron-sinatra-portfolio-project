class CreateWishList < ActiveRecord::Migration[6.0]
  def up
    create_table :wish_lists do |t|
      t.string :name
      t.text :description
      t.integer :user_id

      t.timestamps
    end
  end

  def down
    drop_table :wish_lists
  end
end
