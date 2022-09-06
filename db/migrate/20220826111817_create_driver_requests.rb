class CreateDriverRequests < ActiveRecord::Migration[7.0]
  def change
    create_table :driver_requests do |t|
      t.references :user, null: false, foreign_key: true
      t.string :driver_licence_front
      t.string :driver_licence_back
      t.integer "stage"

      t.timestamps
    end
  end
end
