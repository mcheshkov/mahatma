class Department < ActiveRecord::Base
  validates_presence_of :name, :user_id
  validates_uniqueness_of :name
  validates_associated :person, :parent
  belongs_to :parent, :class_name => "Department"
  has_many :children, :class_name => "Department", :foreign_key => "parent_id"
  belongs_to :person
  has_many :ips
end
