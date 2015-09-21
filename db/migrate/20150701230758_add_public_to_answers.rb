class AddPublicToAnswers < ActiveRecord::Migration
  def change
    add_column :answers, :public, :boolean
  end
end
