class User < ActiveRecord::Base
  attr_accessor :password
  attr_accessible :email, :name, :password, :password_confirmation, :salt

  validates :name, :presence => true, :length => {:maximum => 50}
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :email, :presence => true, format: {:with => VALID_EMAIL_REGEX}, :uniqueness => {:case_sensitive => false}
  validates :password, :presence => true, :confirmation => true, :length => {:within => 6..40}

  before_save :encrypt_password

  private
  def encrypt_password
    self.salt = make_salt if new_record?
    self.encrypted_password = encrypt(password)
  end

  def make_salt
    secure_hash("#{Time.now.utc}--#{password}")
  end

  def encrypt(string)
    secure_hash("#{salt}--#{string}")
  end

  public
  def self.authenticate(email, submitted_password)
    user = find_by_email(email)
    (user && user.has_password?(submitted_password)) ? user : nil
  end

  def self.authenticate_with_salt(id, cookie_salt)
    user = find_by_id(id)
    (user && user.salt == cookie_salt) ? user : nil
  end

  def has_password?(submitted_password)
    encrypted_password == encrypt(submitted_password)
  end

  def secure_hash(string)
    Digest::SHA2.hexdigest(string)
  end
end
