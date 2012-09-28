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

end
