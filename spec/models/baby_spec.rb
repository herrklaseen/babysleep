require 'spec_helper'

describe Baby do
  before do  
    @parent = Parent.new(:name => 'Barney' )
    @user = @parent.create_user(:email => 'user2@example.com', :password => 'secret')
    @baby = Baby.new(:name => 'Kiddy', :date_of_birth => Date.civil(2011, 7, 17))
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

  
end
