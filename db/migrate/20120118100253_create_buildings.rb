class CreateBuildings < ActiveRecord::Migration
  def change
    create_table :buildings do |t|
      t.string :name, :limit => 30, :default => "", :null => false
      t.string :address, :limit => 80, :default => "", :null => false

      t.timestamps
    end
  end
end
