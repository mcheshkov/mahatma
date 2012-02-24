class Ip < ActiveRecord::Base
  validates_presence_of :building_id, :if => "!free?"
  validates_presence_of :department_id, :if => "!free?"
  validates_associated :person, :building, :department
  belongs_to :person
  belongs_to :building
  belongs_to :department
  has_many :inbounds, :foreign_key => "ip"
  has_many :outbounds, :foreign_key => "ip"

  def ip_as_string
    ip2str(ip)
  end

  def ip_as_string=(str)
    self.ip = str2ip(str) if new_record?
  end

  private
  def ip2str(ip)
    return if !ip
    o4=ip % (1 << 8)
    ip>>=8
    o3=ip % (1 << 8)
    ip>>=8
    o2=ip % (1 << 8)
    ip>>=8
    o1=ip % (1 << 8)
    
    o1.to_s + '.' + o2.to_s + '.' + o3.to_s + '.' + o4.to_s
  end
  def str2ip(str)
    return if !str
    ip = 0
    str.split('.').each{ |s|
        ip <<= 8
        ip += s.to_i
    }
    ip
  end
end
