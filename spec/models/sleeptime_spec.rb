require 'spec_helper'

describe Sleeptime do
  before do  
    @baby = Baby.new(:name => 'Kiddy', :date_of_birth => Date.civil(2011, 7, 17))
    @parent = @baby.create_parent(:name => 'Barney')
    @user = @parent.create_user(:email => 'user2@example.com', :password => 'secret')
    @baby.save
  end

  describe 'when sleeptime is passed DateTime-objects and baby' do
    before do
      starttime = DateTime.now - 1.hour
      endtime = DateTime.now
      @sleeptime = Sleeptime.parse(starttime, endtime, @baby)
    end
    it 'should be valid' do
      @sleeptime.should be_valid
    end
  end

  describe 'when duration is negative' do
    before do
      starttime = DateTime.now 
      endtime = DateTime.now - 1.hour
      @sleeptime = Sleeptime.parse(starttime, endtime, @baby)
    end
    it 'sleeptime be invalid' do
      @sleeptime.should be_invalid
    end
  end

  describe 'when sleeptime is passed 24-hour time strings' do
    before do
      starttime = '0430' 
      endtime = '0530'
      @sleeptime = Sleeptime.parse(starttime, endtime, @baby)
    end
    it 'should be valid' do
      @sleeptime.should be_valid
    end
  end

    describe 'when sleeptime is passed erroneous time strings' do
    before do
      starttime = '030' 
      endtime = '530'
      @sleeptime = Sleeptime.parse(starttime, endtime, @baby)
    end
    it 'should not be valid' do
      @sleeptime.should_not be_valid
    end
  end

end
