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

  ## Perhaps this is an overkill test. It checks for
  ## object_id equality to determine that a User instance
  ## can access its Parent attributes on object level. I.e.
  ## both instances point to the same object of class String.

  describe 'its User instance' do
    it 'can access Parent attributes' do
      name_from_parent = @parent.name
      name_from_parent.object_id == @user.parent.name.object_id
    end
  end

end
