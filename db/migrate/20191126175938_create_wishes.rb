class CreateWishes < ActiveRecord::Migration[6.0]
  def up
    create_table :wishes do |t|
      t.string :name
      t.text :description
      t.string :url
      t.integer :wish_list_id

      t.timestamps
    end
  end

  def down
    drop_table :wishes
  end
end
