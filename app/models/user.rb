class User < ActiveRecord::Base
  attr_accessible :email, :name, :password

  validates :name, :presence => true, :length => { :minimum => 5, :maximum => 100 }
  validates :email, :presence => true
  validates :password, :presence => true
end
