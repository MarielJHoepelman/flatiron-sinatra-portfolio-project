class CreateWishes < ActiveRecord::Migration[6.0]
  def up
    create_table :wishes do |t|
      t.string :name
      t.integer :user_id
      t.text :description
      t.string :url
    end
  end

  def down
    drop_table :wishes
  end
end
