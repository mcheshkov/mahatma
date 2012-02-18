class Ip < ActiveRecord::Base
  validates_presence_of :building_id, :if => "!free?"
  validates_presence_of :department_id, :if => "!free?"
  validates_associated :user, :building, :department
  belongs_to :user
  belongs_to :building
  belongs_to :department
  has_many :inbounds, :foreign_key => "ip"
  has_many :outbounds, :foreign_key => "ip"
end
