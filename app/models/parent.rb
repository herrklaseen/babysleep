class Parent < ActiveRecord::Base
  belongs_to :user
  attr_accessible :name

  validates :name, {
        :presence => true, 
        :length => { :minimum => 5, :maximum => 100 }
        }

  validates :user, { :presence => true }
end
