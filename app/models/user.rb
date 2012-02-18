class User < ActiveRecord::Base
  validates_presence_of :name
  validates_uniqueness_of :name
  has_many :departments
  has_many :ips
end
