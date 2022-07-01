class ChangeBirthdayDataTypeToDate < ActiveRecord::Migration[7.0]
  def change
    change_column :users, :birthday, :date, using: "birthday::date"
  end
end
