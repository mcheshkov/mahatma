class IpsAddDepId < ActiveRecord::Migration
  def up
    add_column :ips, :department_id, :integer
  end

  def down
    remove_column :ips, :department_id
  end
end
