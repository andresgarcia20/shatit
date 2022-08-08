class AddTransferReceiptToTripJoinRequest < ActiveRecord::Migration[7.0]
  def change
    add_column :trip_join_requests, :transfer_receipt, :string
  end
end
