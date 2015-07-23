class AddColumnToUsers < ActiveRecord::Migration
  def change
    add_column :users, :max_streak, :integer, :default => 0
  end
end
