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
    return if !ip
    "%d.%d.%d.%d" % octets
  end

  def ip_as_string=(str)
    self.ip = str2ip(str) if new_record?
  end

  def octets
    return if !ip
    _ip = ip
    o4=_ip % (1 << 8)
    _ip>>=8
    o3=_ip % (1 << 8)
    _ip>>=8
    o2=_ip % (1 << 8)
    _ip>>=8
    o1=_ip % (1 << 8)
    [o1,o2,o3,o4]
  end

  def traffic(dir,type,from_date,to_date)
    @@all_traffic ||= get_all_traffic(from_date,to_date)
    @@all_traffic[ [id,dir,type] ] || 0
  end

  private

  def get_all_traffic(from_date,to_date)
    res = {}

    t = Inbound.where("ts >= ? AND ts < ?",from_date,to_date).group("inbound.ip","(HOUR(ts)>=8 AND HOUR(ts)<20)").sum(:bytes)
    t.each do |k,v|
      res[ [k[0], :in, k[1]==1 ? :day : :night] ] = v
    end

    t = Outbound.where("ts >= ? AND ts < ?",from_date,to_date).group("outbound.ip","(HOUR(ts)>=8 AND HOUR(ts)<20)").sum(:bytes)
    t.each do |k,v|
      res[ [k[0], :out, k[1]==1 ? :day : :night] ] = v
    end

    res
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
