class UsersRenameToPersons < ActiveRecord::Migration
  def up
    rename_table :users, :persons
  end

  def down
    rename_table :persons, :users
  end
end
