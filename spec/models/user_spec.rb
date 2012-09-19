require 'spec_helper'

describe User do
	before { @user = User.new(:name => 'First User', :email => 'user@example.com', :password => 'secret') }

	subject { @user }

  it { should be_an_instance_of(User) }

  describe "name must be present" do
	  before { @user.name = " " }
	  it { should_not be_valid }
	end

	  describe "email must be present" do
	  before { @user.email = " " }
	  it { should_not be_valid }
	end

  describe "password must be present" do
	  before { @user.password = " " }
	  it { should_not be_valid }
	end

end
