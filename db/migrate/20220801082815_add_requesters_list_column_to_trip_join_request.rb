class AddRequestersListColumnToTripJoinRequest < ActiveRecord::Migration[7.0]
  def change
    add_column :trip_join_requests, :requesters_list, :jsonb, array: true, default: "{}", using: "requesters_list::character varying[]"
  end
end
