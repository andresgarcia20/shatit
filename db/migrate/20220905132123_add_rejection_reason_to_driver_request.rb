class AddRejectionReasonToDriverRequest < ActiveRecord::Migration[7.0]
  def change
    add_column :driver_requests, :rejection_reason, :string
  end
end
