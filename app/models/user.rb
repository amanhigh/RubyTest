class User < ActiveRecord::Base
  attr_accessor :password
  attr_accessible :email, :name, :password, :password_confirmation

  validates :name, :presence => true, :length => {:maximum => 50}

  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :email, :presence => true, format: {:with => VALID_EMAIL_REGEX}, :uniqueness => {:case_sensitive => false}

  validates :password, :presence => true, :confirmation => true, :length => {:within => 6..40}
end
