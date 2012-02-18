class Building < ActiveRecord::Base
  validates_presence_of :name, :address
  validates_uniqueness_of :name
  has_many :ips
end
