class AddTripStatusToTrip < ActiveRecord::Migration[7.0]
  def change
    add_column :trips, :trip_status, :integer, default: 0
  end
end
