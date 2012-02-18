class CreateLogins < ActiveRecord::Migration
  def change
    create_table :logins do |t|
      t.string :name
      t.string :hashed_password
      t.string :salt
      t.boolean :admin

      t.timestamps
    end
  end
end
