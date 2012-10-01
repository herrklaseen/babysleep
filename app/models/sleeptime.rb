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
    :presence => true, 
    :numericality => { :only_integer => true,
                       :greater_than => 0 }
  }

  def self.parse (starttime = (DateTime.now-24.hours), endtime = DateTime.now, baby_object = nil)
    sleeptime_object = Sleeptime.new
    
    if (baby_object)
      sleeptime_object.baby = baby_object
    end

    if (starttime.class.name == 'DateTime')
      sleeptime_object.start = starttime
    end

    if (sleeptime_object.start? and endtime.class.name  == 'DateTime')
      sleeptime_object.duration = self.create_duration_from_datetime_objects(starttime, endtime)
    end

    if (starttime.class.name  == 'String' and endtime.class.name  == 'String')
      sleeptime_object.duration = self.create_duration_from_strings(starttime, endtime)
      if (sleeptime_object.duration > 0) 
        sleeptime_object.start = DateTime.strptime(starttime, '%H%M')
      end
    end

    sleeptime_object
  end

  private

  def self.create_duration_from_datetime_objects(starttime, endtime)
    duration = endtime.to_i - starttime.to_i
  end

  def self.create_duration_from_strings(starttime, endtime)
    begin 
      start_datetime = DateTime.strptime(starttime, '%H%M')
      end_datetime = DateTime.strptime(endtime, '%H%M')
      duration = self.create_duration_from_datetime_objects(start_datetime, end_datetime)
    rescue ArgumentError, NoMethodError
      duration = 0
    end
    duration
  end

end
