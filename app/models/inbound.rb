class Inbound < ActiveRecord::Base
  set_table_name "inbound"
  validates_presence_of :ip, :ts, :bytes
  belongs_to :ip
  
end
