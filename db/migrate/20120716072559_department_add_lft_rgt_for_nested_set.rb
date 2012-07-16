class DepartmentAddLftRgtForNestedSet < ActiveRecord::Migration
  def up
    add_column :departments, :lft, :integer
    add_column :departments, :rgt, :integer
    Department.rebuild!
  end

  def down
    remove_column :departments, :lft
    remove_column :departments, :rgt
  end
end
