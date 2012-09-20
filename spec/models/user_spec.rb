require 'spec_helper'

describe User do
	before { @user = User.new(:name => 'First User', :email => 'user@example.com', :password => 'secret') }

	subject { @user }

  describe 'name must be present' do
	  before { @user.name = ' ' }
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

	describe 'email must be present' do
	  before { @user.email = ' ' }
	  it { should_not be_valid }
	end

	describe 'email with valid format' do
		it 'should be valid' do
			valid_email_addresses = %w[me@example.com me.too@example.co.uk 
															me+too@ex-ample.com me_me@example.com]
			valid_email_addresses.each do |valid_address|
				@user.email = valid_address
				@user.should be_valid
			end
		end
	end

	describe 'email with invalid format' do
		it 'should not be valid' do
			invalid_email_addresses = %w[me..@example.com me:too@example.co.uk me%too@ex_ample.com]
			invalid_email_addresses.each do |invalid_address|
				@user.email = invalid_address
				@user.should_not be_valid
			end
		end
	end

	describe 'new user with same email' do
		before do
			user_with_same_email = @user.dup
			user_with_same_email.email = @user.email.upcase
			user_with_same_email.save
		end

		it { should_not be_valid }
	end


  describe 'password must be present' do
	  before { @user.password = ' ' }
	  it { should_not be_valid }
	end


end
