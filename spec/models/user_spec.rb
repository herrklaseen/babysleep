require 'spec_helper'

describe User do
	before { @user = User.new(:name => 'First User', :email => 'user@example.com', :password => 'secret') }

	subject { @user }

  it { should be_an_instance_of(User) }

end
