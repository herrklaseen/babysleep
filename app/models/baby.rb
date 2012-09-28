class Baby < ActiveRecord::Base
  attr_accessible :name, :date_of_birth
  belongs_to :parent
  has_many :sleeptimes

  validates :name, {
    :presence => true,
    :length => { :minimum => 2, :maximum => 100 }
  }
  validates :date_of_birth, {
    :presence => true
  }
  validates :parent, {
    :presence => true
  }
 
end
