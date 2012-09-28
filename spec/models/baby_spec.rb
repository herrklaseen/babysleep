require 'spec_helper'

describe Baby do
  before do  
    @baby = Baby.new(:name => 'Kiddy', :date_of_birth => Date.civil(2011, 7, 17))
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

  describe 'can tell' do
    it 'its Parent\'s name' do
      name_from_parent = @parent.name
      @baby.parent.name.object_id.should eq(name_from_parent.object_id)
    end
  end

end
