class FixColumnName < ActiveRecord::Migration
  def change
    rename_column :answers, :public, :public_answer
  end
end
