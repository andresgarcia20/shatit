class CreateTrips < ActiveRecord::Migration[7.0]
  def change
    create_table :trips do |t|
      t.references :user, null: false, foreign_key: true
      t.string :origin
      t.string :destinations
      t.integer :available_seats
      t.datetime :departure_date

      t.timestamps
    end
  end
end
