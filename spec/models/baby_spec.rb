require 'spec_helper'

describe Baby do
  before do  
    @baby = Baby.create(:name => 'Kiddy', :date_of_birth => Date.civil(2011, 7, 17))
    @parent = @baby.create_parent(:name => 'Barney')
    @user = @parent.create_user(:email => 'user2@example.com', :password => 'secret')

    # Adding five hours of sleeptime to this baby
    #
    5.times do |n|
      starttime = DateTime.current - (2 * n).hours
      endtime = (starttime.dup + 1.hours)
      sleeptime = Sleeptime.make_instance(starttime.strftime('%H%M'), endtime.strftime('%H%M'), @baby)
      sleeptime.save!
    end

  end

  subject { @baby }

  describe 'with blank name' do
    before { @baby.name = ' ' }
    it { should_not be_valid }
  end

  describe 'with no date_of_birth' do
    before { @baby.date_of_birth = nil }
    it { should_not be_valid }
  end

  describe 'with no Parent' do
    before { @baby.parent = nil }
    it { should_not be_valid }
  end

  describe 'with five hours of sleeptime' do
    it 'should report that time in seconds' do
      @baby.last_24h_sleeptime[:in_seconds].should eq(5.hours.to_i)
    end
  end


end
