require 'spec_helper'

describe Sleeptime do
  before do  
    @baby = Baby.new(:name => 'Kiddy', :date_of_birth => Date.civil(2011, 7, 17))
    @parent = @baby.create_parent(:name => 'Barney')
    @user = @parent.create_user(:email => 'user2@example.com', :password => 'secret')
    @baby.save
  end


  describe 'when sleeptime is passed 24-hour time strings' do
    before do
      starttime = (DateTime.current() - 2.hours).strftime('%H%M')
      endtime = (DateTime.current() - 1.hour).strftime('%H%M')
      @sleeptime = Sleeptime.make_instance(starttime, endtime, @baby)
    end
    it 'should be valid' do
      @sleeptime.should be_valid
    end
  end

  describe 'when sleeptime start is later than end' do
    before do
      starttime = (DateTime.current() - 1.hours).strftime('%H%M')
      endtime = (DateTime.current() - 2.hour).strftime('%H%M')
      @sleeptime = Sleeptime.make_instance(starttime, endtime, @baby)
    end
    it 'should be valid' do
      @sleeptime.should be_valid
    end
  end

  describe 'when sleeptime is passed erroneous time strings' do
    before do
      # Slicing the strings to make them erroneous
      #
      starttime = (DateTime.current() - 1.hours).strftime('%H%M')[1, 3]
      endtime = (DateTime.current() - 2.hour).strftime('%H%M')[1, 3]
      
      @sleeptime = Sleeptime.make_instance(starttime, endtime, @baby)
    end
    it 'should not be valid' do
      @sleeptime.should_not be_valid
    end
  end

  describe 'when sleeptime starts before 0000' do
    before do
      starttime = (DateTime.current() - 24.hours).strftime('%H%M')
      endtime = (DateTime.current() - 1.hour).strftime('%H%M')
      @sleeptime = Sleeptime.make_instance(starttime, endtime, @baby)
    end
    it 'should be valid' do
      @sleeptime.should be_valid
    end
  end

  describe 'when sleeptime ends after now' do
    before do
      starttime = (DateTime.current() - 1.hours).strftime('%H%M')
      endtime = (DateTime.current() + 1.hours).strftime('%H%M')
      @sleeptime = Sleeptime.make_instance(starttime, endtime, @baby)
    end
    it 'should not be valid' do
      @sleeptime.should_not be_valid
    end
  end

  describe 'when instance is asked for endtime' do
    before do
      starttime = (DateTime.current() - 1.hours).strftime('%H%M')
      @current_time = DateTime.current()
      endtime = @current_time.strftime('%H%M')
      @sleeptime = Sleeptime.make_instance(starttime, endtime, @baby)
    end
    it 'should report endtime in an explicit way' do
      @sleeptime.endtime().should eq @current_time.strftime('%Y %b %d, %H.%M')
    end
  end

  describe 'when instance is passed an endtime string' do
    before do
      starttime = (DateTime.current() - 1.hours).strftime('%H%M')
      @current_time = DateTime.current()
      endtime = @current_time.strftime('%H%M')
      @sleeptime = Sleeptime.make_instance(starttime, endtime, @baby)

      @new_endtime_date_time = @current_time - 5.minutes
      new_endtime_string = (@new_endtime_date_time).strftime('%H%M')

      @sleeptime.endtime = new_endtime_string
    end
    it 'should set a new endtime' do
      @sleeptime.endtime().should eq @new_endtime_date_time.strftime('%Y %b %d, %H.%M')
    end
  end


  describe 'when instance is passed an erroneous endtime string' do
    before do
      starttime = (DateTime.current() - 1.hours).strftime('%H%M')
      @current_time = DateTime.current()
      endtime = @current_time.strftime('%H%M')
      @sleeptime = Sleeptime.make_instance(starttime, endtime, @baby)
      @new_endtime_date_time = @current_time - 5.minutes

      # Slicing string to make it erroneuos
      #
      new_erroneous_endtime_string = (@new_endtime_date_time).strftime('%H%M')[1, 3]
      @sleeptime.endtime = new_erroneous_endtime_string
    end
    it 'should not set a new endtime' do
      @sleeptime.endtime().should eq @current_time.strftime('%Y %b %d, %H.%M')
    end
  end

  describe 'when instance is passed a starttime string' do
    before do
      starttime = (DateTime.current() - 1.hours).strftime('%H%M')
      @current_time = DateTime.current()
      endtime = @current_time.strftime('%H%M')
      @sleeptime = Sleeptime.make_instance(starttime, endtime, @baby)

      @new_starttime_date_time = @current_time - 50.minutes
      new_starttime_string = (@new_starttime_date_time).strftime('%H%M')

      @sleeptime.starttime = new_starttime_string
    end
    it 'should set a new starttime' do
      @sleeptime.starttime().should eq @new_starttime_date_time.strftime('%Y %b %d, %H.%M')
    end
  end




end






