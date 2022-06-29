class ChangeTypeToArrayInTrip < ActiveRecord::Migration[7.0]
  def change
    change_column :trips, :destinations, :string, array: true, default: "{}", using: "destinations::character varying[]"
  end
end
