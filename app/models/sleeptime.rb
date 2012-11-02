class Sleeptime < ActiveRecord::Base
  EXPLICIT_DATE_FORMAT = '%Y %b %d, %H.%M'
  CONVERSION_DATE_FORMAT = '%Y-%m-%dT%H:%M'
  attr_accessible :start, :duration
  belongs_to :baby, :inverse_of => :sleeptimes

  default_scope order('start DESC')

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

  def starttime()
    start.strftime(EXPLICIT_DATE_FORMAT)
  end

  def starttime=(new_starttime_string)
    new_starttime_string = prepare_time_string_for_parse(new_starttime_string) { start }
    begin
      date_time_start = Sleeptime::parse(new_starttime_string)
    rescue Exception => e
      return false    
    end

    self.start = date_time_start
    self.save!
  end

  def endtime()
    endtime = end_datetime()
    endtime.strftime(EXPLICIT_DATE_FORMAT)
  end

  def end_datetime()
    end_datetime = DateTime.strptime((start.to_i + duration).to_s, '%s').in_time_zone()
  end

  def endtime=(new_endtime_string)
    new_endtime_string = prepare_time_string_for_parse(new_endtime_string) { end_datetime }

    begin
      date_time_end = Sleeptime::parse(new_endtime_string)
    rescue Exception => e
      return false    
    end
    self.duration = Sleeptime::create_duration(start, date_time_end)
    self.save!
  end

  def description()
    start.strftime('%b %d, %H.%M: ') << Sleeptime::seconds_to_human_readable(duration)
  end

  def self.make_instance (starttime, endtime, baby_object = nil)
    sleeptime_object = Sleeptime.new
    sleeptime_object.baby = baby_object
    current_time = DateTime.current()

    begin
      sleeptime_object.start = self.parse(starttime)
      endtime = self.parse(endtime)
    rescue ArgumentError
      sleeptime_object.start = nil
    end

    if (sleeptime_object.start?)
      case 
        when sleeptime_object.start > endtime
          sleeptime_object.start += -24.hours
        when (sleeptime_object.start > current_time and endtime > current_time)
          sleeptime_object.start += -24.hours
          endtime += -24.hours
        when endtime > current_time
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
    date_time = case date_string.length
      when 4 then
        formatted_time_string = "#{date_string[0,2]}:#{date_string[2,2]}"
        Time.zone.parse(formatted_time_string)
      else
        date_time_for_conversion = DateTime.strptime(date_string, EXPLICIT_DATE_FORMAT)
        formatted_time_string = date_time_for_conversion.strftime(CONVERSION_DATE_FORMAT)
        Time.zone.parse(formatted_time_string)
    end
    date_time  
  end

  def self.create_duration(starttime, endtime)
    duration = endtime.to_i - starttime.to_i
  end

  private 

  def prepare_time_string_for_parse(time_string)
    time_string = case time_string.length
      when 4 
        relevant_date_time = yield
        date_string = relevant_date_time.strftime('%Y %b %d, ')
        formatted_time_string = time_string[0, 2] << '.' << time_string[2, 2]
        date_string << formatted_time_string
      else time_string
    end
  end

end
