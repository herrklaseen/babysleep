require 'spec_helper'

describe Baby do
  before do  
    @baby = Baby.create(:name => 'Kiddy', :date_of_birth => Date.civil(2011, 7, 17))
    @parent = @baby.create_parent(:name => 'Barney')
    @user = @parent.create_user(:email => 'user2@example.com', :password => 'secret')

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
    before do
      5.times do |n|
        starttime = (DateTime.current() - (n + 2).hours).strftime('%H%M')
        endtime = (DateTime.current() - (n + 1).hours).strftime('%H%M')
        sleeptime = Sleeptime.make_instance(starttime, endtime, @baby)
        sleeptime.save!
      end
    end

    context 'reporting in seconds' do
      it 'should report that time in seconds' do
        @baby.last_24h_sleeptime[:in_seconds].should eq(5.hours.to_i)
      end
    end

    context 'reporting in percentage' do
      it 'should report that time as percent of 24 hours' do
        @baby.last_24h_sleeptime[:percentage].should eq([21, 79])
      end
    end
  end

end
