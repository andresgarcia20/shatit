class FixKidsNameInTrips < ActiveRecord::Migration[7.0]
  def change
    rename_column :trips, :kids, :kids_age_range
  end
end
