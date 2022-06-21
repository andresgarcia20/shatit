class DropAgeFromUser < ActiveRecord::Migration[7.0]
  def change
    remove_column :users, :age
  end
end
