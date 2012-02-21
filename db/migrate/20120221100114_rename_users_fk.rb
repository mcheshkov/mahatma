class RenameUsersFk < ActiveRecord::Migration
  def up
    rename_column :ips, :user_id, :person_id
    rename_column :departments, :user_id, :person_id
  end

  def down
    rename_column :ips, :person_id, :user_id
    rename_column :departments, :person_id, :user_id
  end
end
