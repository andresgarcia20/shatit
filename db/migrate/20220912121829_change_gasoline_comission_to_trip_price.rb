class ChangeGasolineComissionToTripPrice < ActiveRecord::Migration[7.0]
  def change
    rename_column :trips, :gasoline_comission, :trip_price
  end
end
