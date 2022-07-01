class AddVehicleRefToTrip < ActiveRecord::Migration[7.0]
  def change
    add_reference :trips, :vehicle, null: false, foreign_key: true
  end
end
