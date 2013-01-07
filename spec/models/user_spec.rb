require 'spec_helper'

describe User do
  before do
    @user = User.new(:email => 'user@example.com', :password => 'secret', :password_confirmation => 'secret')
    @user.parent.stub(:valid?).and_return(true)
  end 

  subject { @user }

  describe 'with blank email' do
    before { @user.email = ' ' }
    it { should_not be_valid }
  end

  describe 'with valid email format' do
    it 'should be valid' do
      valid_email_addresses = %w[me@example.com me.too@example.co.uk
                                me+too@ex-ample.com me_me@example.com]
      valid_email_addresses.each do |valid_address|
        @user.email = valid_address
        @user.should be_valid
      end
    end
  end

  describe 'with invalid email format' do
    it 'should not be valid' do
      invalid_email_addresses = %w[me..@example.com me:too@example.co.uk me%too@ex_ample.com]
      invalid_email_addresses.each do |invalid_address|
        @user.email = invalid_address
        @user.should_not be_valid
      end
    end
  end

  describe 'with same email as another user' do
    before do
      user_with_same_email = @user.dup
      user_with_same_email.email = @user.email.upcase
      user_with_same_email.save
    end

    it { should_not be_valid }
  end

  describe 'with blank password' do
    before { @user.password = ' ' }
    it { should_not be_valid }
  end

end
