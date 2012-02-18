class IpsAddFree < ActiveRecord::Migration
  def up
    add_column :ips, :free, :boolean
  end

  def down
    remove_column :ips, :free
  end
end
