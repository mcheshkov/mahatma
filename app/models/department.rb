class Department < ActiveRecord::Base
  validates_presence_of :name, :user_id
  validates_uniqueness_of :name
  validates_associated :user, :parent
  belongs_to :parent, :class_name => "Department"
  belongs_to :user
end
