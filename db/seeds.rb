# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

Time.zone = 'Amsterdam'

# Generate user

email = 'user@example.com'
password = 'secret'

@user = User.create!( :email => email,
              :password => password,
              :password_confirmation => password )

# Generate parent

name = 'A User'
@parent = Parent.new( :name => name )
@parent.user = @user
@parent.save!

# Generate babies

names = ['Kiddy One', 'Kiddy Two']
names.each do |name|
  date_of_birth = Date.current - rand(4).years - rand(12).months
  baby = Baby.new( :name => name, 
                    :date_of_birth => date_of_birth )
  baby.parent = @parent
  baby.save!
end

# Generate sleeptimes

babies = Baby.all

babies.each do |baby|
  5.times do |n|
    starttime = DateTime.current - (3 * (n + 1)).hours
    endtime = (starttime.dup + 30.minutes) - rand(15).minutes
    sleeptime = Sleeptime.make_instance(starttime.strftime('%H%M'), endtime.strftime('%H%M'), baby)
    sleeptime.save!
  end
end

# For user test

# @user = User.create!( :email => 'test@test.com', :password => 'test' )
# @parent = Parent.new( :name => 'Tester' )
# @parent.user = @user
# @parent.save!
# @baby = Baby.new( :name => 'Lilla Ruffa', 
#   :date_of_birth => Date.current() - 18.months )
# @baby.parent = @parent
# @baby.save!
