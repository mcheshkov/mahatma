class CreateIps < ActiveRecord::Migration
  def up
    #Trick - no id, manually add PK statement
    #MySQL only
    #Need to set 'ip' both PK and UNSIGNED
    create_table :ips, :id => false do |t|
      t.column :ip, 'INT UNSIGNED NOT NULL'
      t.references :user
      t.references :building
      t.string :room
      t.string :comment

      t.timestamps
    end
    execute "ALTER TABLE ips ADD PRIMARY KEY ( `ip` );"
    execute "ALTER TABLE ips CHANGE COLUMN `ip` `ip` INT UNSIGNED NOT NULL AUTO_INCREMENT FIRST;"
  end

  def down
    drop_table :ips
  end
end
