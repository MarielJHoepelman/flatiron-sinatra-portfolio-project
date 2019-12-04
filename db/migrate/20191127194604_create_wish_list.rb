class CreateWishList < ActiveRecord::Migration[6.0]
  def up
    create_table :wish_lists do |t|
      t.string :name
      t.integer :user_id

      t.timestamps
    end
  end

  def down
    drop_table :users
  end
end

# rake db:migrate:up SINATRA_ENV=test VERSION=20191127194604
