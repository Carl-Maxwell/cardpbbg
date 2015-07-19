class AddComputerTokenToSessions < ActiveRecord::Migration
  def change
    add_column :sessions, :computer_token, :string
  end
end
