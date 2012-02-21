class Person < ActiveRecord::Base
  set_table_name :persons
  validates_presence_of :name
  validates_uniqueness_of :name
  has_many :departments
  has_many :ips
end
