class RemoveComputerTokenOnSessions < ActiveRecord::Migration
  def change
    remove_column :sessions, :computer_token
  end
end
