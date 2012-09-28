class Parent < ActiveRecord::Base
  attr_accessible :name
  belongs_to :user, :inverse_of => :parent

  validates :name, {
        :presence => true, 
        :length => { :minimum => 5, :maximum => 100 }
        }

  validates :user, { :presence => true }
end
