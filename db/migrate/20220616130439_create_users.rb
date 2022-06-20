class CreateUsers < ActiveRecord::Migration[7.0]
  def change
    create_table :users do |t|
      t.text :name
      t.string :surname
      t.string :nickname
      t.integer :phone_number
      t.date :birthday
      t.string :email

      t.timestamps
    end
  end
end
