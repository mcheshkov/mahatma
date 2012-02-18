class Outbound < ActiveRecord::Base
  set_table_name "outbound"
  validates_presence_of :ip, :ts, :bytes
  belongs_to :ip
end
