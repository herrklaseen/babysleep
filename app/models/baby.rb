class Baby < ActiveRecord::Base
  attr_accessible :date_of_birth, :name
  belongs_to :parent

  validates :name {
    :presence => true,
    :length => { :minimum => 2, :maximum => 100 }
    }
  validates :date_of_birth {
    :presence => true
    }
  
end
