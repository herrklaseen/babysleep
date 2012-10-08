require 'active_support/core_ext/enumerable'

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

  # TO DO: Missing support for creating 'human readable' durations.
  #
  def last_24h_sleeptime()
    sleeptime_last_24h = { :for_humans => nil,
                           :in_seconds => 0 }
    twentyfour_h_ago = DateTime.current - 24.hours
    self.sleeptimes.each do |sleeptime|
      if (sleeptime.start > twentyfour_h_ago)
        sleeptime_last_24h[:in_seconds] += sleeptime.duration
      end
    end

    sleeptime_last_24h[:for_humans] = 
        Sleeptime.seconds_to_human_readable(sleeptime_last_24h[:in_seconds])
    sleeptime_last_24h
  end

 
end
