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


end
