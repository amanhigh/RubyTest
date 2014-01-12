class User < ActiveRecord::Base
  has_secure_password

  has_many :microposts, :dependent => :destroy
  has_many :relationships, :dependent => :destroy, :foreign_key => "follower_id"
  has_many :reverse_relationships, :dependent => :destroy, :foreign_key => "followed_id", :class_name => "Relationship"
  has_many :followed_users, :through => :relationships, :source => :followed
  has_many :followers, :through => :reverse_relationships, :source => :follower

  validates :name, :presence => true, :length => {:maximum => 50}
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z]+)*\.[a-z]+\z/i
  validates :email, :presence => true, format: {with: VALID_EMAIL_REGEX}, :uniqueness => {:case_sensitive => false}
  validates :password, :presence => true, :confirmation => true, :length => {:within => 6..40}

  before_save { create_remember_token }
  before_save { self.email.downcase! }
  public

  def feed
    Micropost.where("user_id = ?", id)
  end

  def User.new_remember_token
    SecureRandom.urlsafe_base64
  end

  def User.encrypt(token)
    Digest::SHA1.hexdigest(token.to_s)
  end

  def following?(followed)
    relationships.find_by_followed_id(followed)
  end

  def follow!(followed)
    relationships.create!(:followed_id => followed.id)
  end

  def unfollow!(followed)
    relationships.find_by_followed_id(followed).destroy
  end

  private
  def create_remember_token
    self.remember_token = User.encrypt(User.new_remember_token)
  end
end
