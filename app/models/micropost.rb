class Micropost < ActiveRecord::Base
  validates :content, :presence => true, :length => {:maximum => 140}

  belongs_to :user

  default_scope :order => 'microposts.created_at DESC'
end
