class AddUseragentToSessions < ActiveRecord::Migration
  def change
    add_column :sessions, :useragent, :string
  end
end
