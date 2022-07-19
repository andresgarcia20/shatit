class CreateTripJoinRequests < ActiveRecord::Migration[7.0]
  def change
    create_table :trip_join_requests do |t|
      t.integer :companions
      t.integer :pets
      t.integer :luggage
      t.string :kids
      t.integer :stage
      t.references :user, null: false, foreign_key: true
      t.references :trip, null: false, foreign_key: true

      t.timestamps
    end
  end
end
