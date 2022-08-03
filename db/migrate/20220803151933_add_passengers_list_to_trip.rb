class AddPassengersListToTrip < ActiveRecord::Migration[7.0]
  def change
    add_column :trips, :passengers_list, :jsonb, array: true, default: "{}", using: "passengers_list::character varying[]"
  end
end
