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
    sleeptime_object.baby = baby_object

    if (starttime.respond_to?('minute'))
      sleeptime_object.start = starttime
    else
      begin
        sleeptime_object.start = DateTime.strptime(starttime, '%H%M')
      rescue ArgumentError
        sleeptime_object.start = nil
      end
    end

    if (sleeptime_object.start?)
      sleeptime_object.duration = self.create_duration(sleeptime_object.start, endtime)
    end

    sleeptime_object
  end

  private

  def self.create_duration(starttime, endtime)
    if (endtime.respond_to?('minute'))
      duration = endtime.to_i - starttime.to_i
    else
      begin
        endtime = DateTime.strptime(endtime, '%H%M')
        duration = self.create_duration(starttime, endtime)
      rescue ArgumentError
        duration = 0
      end
    end

    duration
  end

end
