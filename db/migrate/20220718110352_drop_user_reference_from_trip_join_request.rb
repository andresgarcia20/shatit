class DropUserReferenceFromTripJoinRequest < ActiveRecord::Migration[7.0]
  def change
    remove_column :trip_join_requests, :user_id
  end
end
