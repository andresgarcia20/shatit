class AddExtraDetailsToTrip < ActiveRecord::Migration[7.0]
  def change
    add_column :trips, :pets, :integer
    add_column :trips, :luggage, :integer
    add_column :trips, :kids, :integer
    add_column :trips, :gasoline_comission, :integer
  end
end
