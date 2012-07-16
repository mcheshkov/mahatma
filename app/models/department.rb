class Department < ActiveRecord::Base
  validates_presence_of :name, :person_id
  validates_uniqueness_of :name
  validates_associated :person
  acts_as_nested_set
  belongs_to :person
  has_many :ips
  has_many :inbounds, :through => :ips
  has_many :outbounds, :through => :ips

  def total_traffic(dir,type,from_date,to_date)
    res = 0
    all_ips.each do |ip|
      res += ip.traffic(dir,type,from_date,to_date)
    end
    res
  end

  def all_ips
    res = []
    self_and_descendants.each {|d| res += d.ips}
    res
  end

end
