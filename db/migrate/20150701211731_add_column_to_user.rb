class AddColumnToUser < ActiveRecord::Migration
  def change
    add_column :users, :last_sent_question, :integer
  end
end
