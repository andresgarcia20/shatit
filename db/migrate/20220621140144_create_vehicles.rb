class CreateVehicles < ActiveRecord::Migration[7.0]
  def change
    create_table :vehicles do |t|
      t.references :user, null: false, foreign_key: true
      t.string :model
      t.boolean :air_conditioning
      t.integer :vehicle_type
      t.float :consumption
      t.string :nickname

      t.timestamps
    end
  end
end
