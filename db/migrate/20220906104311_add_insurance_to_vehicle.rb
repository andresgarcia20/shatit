class AddInsuranceToVehicle < ActiveRecord::Migration[7.0]
  def change
    add_column :vehicles, :insurance, :string
    add_column :vehicles, :car_revision, :string
  end
end
