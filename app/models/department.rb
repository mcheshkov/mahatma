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

  @@all_in_traffic = {}
  @@all_out_traffic = {}

  def in_traffic(from_date,to_date)
    daily_in_traffic(from_date,to_date) + night_in_traffic(from_date,to_date)
  end

  def daily_in_traffic(from_date,to_date)
    @@all_in_traffic[ [from_date,to_date] ] ||= get_all_in_traffic(from_date,to_date)
    @@all_in_traffic[ [from_date,to_date] ][ [id,1] ] || 0
  end

  def night_in_traffic(from_date,to_date)
    @@all_in_traffic[ [from_date,to_date] ] ||= get_all_in_traffic(from_date,to_date)
    @@all_in_traffic[ [from_date,to_date] ][ [id,0] ] || 0
  end

  def total_in_traffic(from_date,to_date)
    res = in_traffic(from_date,to_date)
    children.each do |c|
      res += c.in_traffic(from_date,to_date)
    end
    res
  end

  def total_daily_in_traffic(from_date,to_date)
    res = daily_in_traffic(from_date,to_date)
    children.each do |c|
      res += c.daily_in_traffic(from_date,to_date)
    end
    res
  end

  def total_night_in_traffic(from_date,to_date)
    res = night_in_traffic(from_date,to_date)
    children.each do |c|
      res += c.night_in_traffic(from_date,to_date)
    end
    res
  end



  def out_traffic(from_date,to_date)
    daily_out_traffic(from_date,to_date) + night_out_traffic(from_date,to_date)
  end

  def daily_out_traffic(from_date,to_date)
    @@all_out_traffic[ [from_date,to_date] ] ||= get_all_out_traffic(from_date,to_date)
    @@all_out_traffic[ [from_date,to_date] ][ [id,1] ] || 0
  end

  def night_out_traffic(from_date,to_date)
    @@all_out_traffic[ [from_date,to_date] ] ||= get_all_out_traffic(from_date,to_date)
    @@all_out_traffic[ [from_date,to_date] ][ [id,0] ] || 0
  end

  def total_out_traffic(from_date,to_date)
    res = out_traffic(from_date,to_date)
    children.each do |c|
      res += c.out_traffic(from_date,to_date)
    end
    res
  end

  def total_daily_out_traffic(from_date,to_date)
    res = daily_out_traffic(from_date,to_date)
    children.each do |c|
      res += c.daily_out_traffic(from_date,to_date)
    end
    res
  end

  def total_night_out_traffic(from_date,to_date)
    res = night_out_traffic(from_date,to_date)
    children.each do |c|
      res += c.night_out_traffic(from_date,to_date)
    end
    res
  end

  private
  def get_all_in_traffic(from_date,to_date)
    Ip.joins(:inbounds).where("ts >= ? AND ts < ?",from_date,to_date).group(:department_id,"(HOUR(ts)>=8 AND HOUR(ts)<20)").sum(:bytes)
  end

  def get_all_out_traffic(from_date,to_date)
    Ip.joins(:outbounds).where("ts >= ? AND ts < ?",from_date,to_date).group(:department_id,"(HOUR(ts)>=8 AND HOUR(ts)<20)").sum(:bytes)
  end
end
