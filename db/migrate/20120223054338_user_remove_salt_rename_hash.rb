class UserRemoveSaltRenameHash < ActiveRecord::Migration
  def up
    remove_column :users, :salt
    rename_column :users, :hashed_password, :password_digest
  end

  def down
    rename_column :users, :password_digest, :hashed_password
    add_column :users, :salt, :string
  end
end
