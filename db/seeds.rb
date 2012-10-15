# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

# Generate user

email = 'user@example.com'
password = 'secret'

@user = User.create!( :email => email,
              :password => password )

# Generate parent

name = 'A User'
@parent = Parent.new( :name => name )
@parent.user = @user
@parent.save!

# Generate baby

name = 'Kiddy'
date_of_birth = Date.current - rand(4).years - rand(12).months
@baby = Baby.new( :name => name, 
                  :date_of_birth => date_of_birth )
@baby.parent = @parent
@baby.save!

# Generate sleeptimes

5.times do |n|
  starttime = DateTime.current - (2 * n).hours
  endtime = (starttime.dup + 1.hours) - rand(20).minutes
  sleeptime = Sleeptime.make_instance(starttime.strftime('%H%M'), endtime.strftime('%H%M'), @baby)
  sleeptime.save!
end