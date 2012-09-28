class Sleeptime < ActiveRecord::Base
  attr_accessible :start, :duration
  belongs_to :baby, :inverse_of => :sleeptimes

  validates :baby, {
    :presence => true
  }
  validates :start, {
    :presence => true
  }
  validates :duration, {
    :presence => true
  }

  def self.parse (starttime = (DateTime.now-24.hours), endtime = DateTime.now, baby_object = nil)
    sleeptime_object = Sleeptime.new
    sleeptime_object.start = starttime
    
    if (baby_object)
      sleeptime_object.baby = baby_object
    end

    if (starttime.class.name  == 'DateTime' and endtime.class.name  == 'DateTime')
      sleeptime_object.duration = self.create_duration_from_datetime_objects(starttime, endtime)
    end

    sleeptime_object
  end

  private

  def self.create_duration_from_datetime_objects(starttime, endtime)
    duration = endtime.to_i - starttime.to_i
  end

end
