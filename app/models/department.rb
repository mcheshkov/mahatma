class Department < ActiveRecord::Base
  validates_presence_of :name, :person_id
  validates_uniqueness_of :name
  validates_associated :person, :parent
  belongs_to :parent, :class_name => "Department"
  has_many :children, :class_name => "Department", :foreign_key => "parent_id"
  belongs_to :person
  has_many :ips
  has_many :inbounds, :through => :ips
  has_many :outbounds, :through => :ips

  def traffic(dir,type,from_date,to_date)
    @@all_traffic ||= get_all_traffic(from_date,to_date)
    @@all_traffic[ [id,dir,type] ] || 0
  end

  def total_traffic(dir,type,from_date,to_date)
    res = traffic(dir,type,from_date,to_date)
    children.each do |c|
      res += c.traffic(dir,type,from_date,to_date)
    end
    res
  end

  private
  def get_all_traffic(from_date,to_date)
    res = {}

    t = Ip.joins(:inbounds).where("ts >= ? AND ts < ?",from_date,to_date).group(:department_id,"(HOUR(ts)>=8 AND HOUR(ts)<20)").sum(:bytes)
    t.each do |k,v|
      res[ [k[0], :in, k[1]==1 ? :day : :night] ] = v
    end

    t = Ip.joins(:outbounds).where("ts >= ? AND ts < ?",from_date,to_date).group(:department_id,"(HOUR(ts)>=8 AND HOUR(ts)<20)").sum(:bytes)
    t.each do |k,v|
      res[ [k[0], :out, k[1]==1 ? :day : :night] ] = v
    end

    res
  end
end
