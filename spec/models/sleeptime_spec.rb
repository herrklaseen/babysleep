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
      starttime = '0430' 
      endtime = '0530'
      @sleeptime = Sleeptime.make_instance(starttime, endtime, @baby)
    end
    it 'should be valid' do
      @sleeptime.should be_valid
    end
  end

  describe 'when sleeptime start is later than end' do
    before do
      starttime = '0530'
      endtime = '0430'
      @sleeptime = Sleeptime.make_instance(starttime, endtime, @baby)
    end
    it 'should be valid' do
      @sleeptime.should be_valid
    end
  end

  describe 'when sleeptime is passed erroneous time strings' do
    before do
      starttime = '030' 
      endtime = '530'
      @sleeptime = Sleeptime.make_instance(starttime, endtime, @baby)
    end
    it 'should not be valid' do
      @sleeptime.should_not be_valid
    end
  end

  describe 'when sleeptime starts before 0000' do
    before do
      starttime = DateTime.current() - 24.hours
      starttime = starttime.strftime('%H%M')
      endtime = '1000'
      @sleeptime = Sleeptime.make_instance(starttime, endtime, @baby)
    end
    it 'should be valid' do
      @sleeptime.should be_valid
    end
  end

  describe 'when sleeptime ends after now' do
    before do
      starttime = DateTime.current() - 1.hours
      starttime = starttime.strftime('%H%M')
      endtime = DateTime.current() + 1.hours
      endtime = endtime.strftime('%H%M')
      @sleeptime = Sleeptime.make_instance(starttime, endtime, @baby)
    end
    it 'should not be valid' do
      @sleeptime.should_not be_valid
    end
  end


end
