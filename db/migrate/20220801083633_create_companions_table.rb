class CreateCompanionsTable < ActiveRecord::Migration[7.0]
  def change
    create_table :companions_tables do |t|
      t.string :name
      t.string :surname
      t.integer :phone_number

      t.timestamps
    end
  end
end
