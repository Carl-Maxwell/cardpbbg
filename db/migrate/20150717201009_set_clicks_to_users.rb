class SetClicksToUsers < ActiveRecord::Migration
  def change
    change_column_default :users, :click, 0
  end
end
