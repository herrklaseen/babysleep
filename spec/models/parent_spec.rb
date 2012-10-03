require 'spec_helper'

describe Parent do
  before do  
    @user = User.new(:email => 'user2@example.com', :password => 'secret')
    @parent = Parent.new(:name => 'Barney' )
    @parent.user = @user
  end

  subject { @parent }

  describe 'with blank name' do
    before { @parent.name = ' ' }
    it { should_not be_valid }
  end

  describe 'with no user' do
    before { @parent.user = nil } 
    it { should_not be_valid }
  end

  describe 'with two babies' do
    before do
     baby1 = Baby.new(:name => 'Kid1', :date_of_birth => Date.civil(2011, 6, 1))
     baby2 = Baby.new(:name => 'Kid2', :date_of_birth => Date.civil(2012, 6, 1))
     @parent.babies = [ baby1, baby2 ]
    end
    it 'should have two babies' do
      @parent.babies.length.should eq(2)
    end
  end

end
