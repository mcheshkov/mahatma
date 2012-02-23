class User < ActiveRecord::Base
  require 'digest/md5'

  validates_presence_of :name
  validates_uniqueness_of :name

  has_secure_password
end
