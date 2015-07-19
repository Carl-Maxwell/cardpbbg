class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :email
      t.string :password_digest
      t.integer :click
      t.datetime :last_click_time

      t.timestamps null: false
    end
    add_index :users, :email
    add_index :users, :password_digest
  end
end
