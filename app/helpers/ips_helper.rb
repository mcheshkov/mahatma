module IpsHelper
  def ip2str(ip)
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
    ip = 0
    str.split('.').each{ |s|
        ip <<= 8
        ip += s.to_i
    }
    ip
  end
end
