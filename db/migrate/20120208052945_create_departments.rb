class CreateDepartments < ActiveRecord::Migration
  def change
    create_table :departments do |t|
      t.string :name
      t.references :user
      t.references :parent

      t.timestamps
    end
  end
end
