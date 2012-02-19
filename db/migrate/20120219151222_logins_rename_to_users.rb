class LoginsRenameToUsers < ActiveRecord::Migration
  def up
    rename_table :logins, :users
  end

  def down
    rename_table :users, :logins
  end
end
