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

  def self.make_instance (starttime, endtime, baby_object = nil)
    sleeptime_object = Sleeptime.new
    sleeptime_object.baby = baby_object

    begin
      sleeptime_object.start = self.parse(starttime)
      endtime = self.parse(endtime)
    rescue ArgumentError
      sleeptime_object.start = nil
    end

    if (sleeptime_object.start?)
      if (sleeptime_object.start > endtime)
        sleeptime_object.start += -24.hours
      end

      if (endtime > DateTime.current())
        return sleeptime_object
      end

      sleeptime_object.duration = self.create_duration(sleeptime_object.start, endtime)
    end

    sleeptime_object
  end

  def self.seconds_to_human_readable(seconds, locale='en')
    hours = (seconds / 1.hour.to_i).floor
    remaining_seconds = seconds - (hours * 1.hour.to_i)
    minutes = (remaining_seconds / 1.minute.to_i).floor
    "#{hours} h, #{minutes} min"
  end

  def self.seconds_to_percentage_of_24h(seconds)
    sleep_percentage = ((seconds / 24.hours.to_f) * 100).round
    wake_percentage = 100 - sleep_percentage
    [sleep_percentage, wake_percentage]
  end

  private

  def self.parse(date_string) 
    DateTime.strptime(date_string, '%H%M')
  end

  def self.create_duration(starttime, endtime)
    duration = endtime.to_i - starttime.to_i
  end

end
