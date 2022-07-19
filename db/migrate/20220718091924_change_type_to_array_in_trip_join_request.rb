class ChangeTypeToArrayInTripJoinRequest < ActiveRecord::Migration[7.0]
  def change
    change_column :trip_join_requests, :kids, :string, array: true, default: "{}", using: "kids::character varying[]"
  end
end
