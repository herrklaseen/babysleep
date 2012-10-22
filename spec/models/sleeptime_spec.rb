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


end
