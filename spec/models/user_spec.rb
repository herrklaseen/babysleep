require 'spec_helper'

describe User do
	before { @user = User.new(:name => 'First User', :email => 'user@example.com', :password => 'secret') }

	subject { @user }

  describe 'name must be present' do
	  before { @user.name = ' ' }
	  it { should_not be_valid }
	end

	  describe 'email must be present' do
	  before { @user.email = ' ' }
	  it { should_not be_valid }
	end

  describe 'password must be present' do
	  before { @user.password = ' ' }
	  it { should_not be_valid }
	end

	describe 'name must be longer than 4 characters' do
	  before { @user.name = 'a' * 4 }
	  it { should_not be_valid }
	end

	describe 'name must be shorter than 100 characters' do
	  before { @user.name = 'a' * 101 }
	  it { should_not be_valid }
	end

end
