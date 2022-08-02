class RenameCompanionsTableToCompanions < ActiveRecord::Migration[7.0]
  def change
    rename_table :companions_tables, :companions
  end
end
