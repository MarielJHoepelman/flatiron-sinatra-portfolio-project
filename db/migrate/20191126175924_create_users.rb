class CreateUsers < ActiveRecord::Migration[6.0]
  def up
    create_table :users do |t|
      t.string :name
      t.string :username
      t.string :email
      t.string :password_digest
    end
  end

  def down
    drop_table :users
  end
end

# rake db:migrate:up SINATRA_ENV=test VERSION=20191126175924
