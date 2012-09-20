class User < ActiveRecord::Base
  attr_accessible :email, :name, :password

  VALID_EMAIL_REGEX = /\A([\w+\-_]+(\.)?)+@{1}([\w\-]+\.)+[a-z\d]{2,4}\z/i

  validates :name, :presence => true, :length => { :minimum => 5, :maximum => 100 }
  validates :email, :presence => true, :format => { :with => VALID_EMAIL_REGEX }
  validates :password, :presence => true
end
