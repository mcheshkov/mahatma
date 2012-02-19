class User < ActiveRecord::Base
  require 'digest/md5'

  validates_presence_of :name
  validates_uniqueness_of :name
  
  attr_accessor :password, :password_confirmation
  validates_confirmation_of :password
  before_save :make_hash, :if => :password_changed?

  def self.authenticate(name, pass)
    user = User.find_by_name(name)
    if user
      expected_pass = User.password_hash(pass,user.salt)
      if expected_pass != user.hashed_password
        user=nil
      end
    end
    user
  end

  private

  def password_changed?
    !password.blank?
  end

  def make_hash
    make_salt
    self.hashed_password = User.password_hash(self.password,self.salt)
  end

  def make_salt
    self.salt=name+rand.to_s
  end

  def self.password_hash(pass,salt)
    Digest::MD5.hexdigest(pass+salt)
  end
end
