class CreateChefs < ActiveRecord::Migration
  def change
    create_table :chefs do |t|
      t.string :username
      t.string :email
      t.timestamps null: false
    end
  end
end
