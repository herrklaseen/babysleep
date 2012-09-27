class User < ActiveRecord::Base
  attr_accessible :email, :password
  has_one :parent, :inverse_of => :user

  before_save { |user| user.email = user.email.downcase }

  VALID_EMAIL_REGEX = /\A([\w+\-_]+(\.)?)+@{1}([\w\-]+\.)+[a-z\d]{2,4}\z/i

  validates :email, 
  			:presence => true, 
  			:format => { :with => VALID_EMAIL_REGEX }, 
  			:uniqueness => { :case_sensitive => false }
  validates :password, 
  			:presence => true
end
