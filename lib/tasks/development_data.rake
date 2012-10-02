require 'faker'

namespace :db do
  desc "Fill database with development data"
  task :populate => :environment do
    Rake::Task['db:reset'].invoke
    
    #Generating users

    10.times do |n|
      email  = Faker::Internet.email
      password = 'secret' << n.to_s
      User.create!( 
                    :email => email,
                    :password => password
                  )
    end

    #Generating parents

    users = User.find(:all)

    8.times do |n|
      name = Faker::Name.name
      parent = Parent.new( :name => name )
      parent.user = users[n]
      parent.save!
    end

    users = nil

    #Generating babies

    parents = Parent.find(:all)

    parents.each do |parent|
      name = Faker::Name.first_name
      date_of_birth = Date.current
      date_of_birth += -rand(4).years
      date_of_birth += -rand(12).months
      baby = Baby.new( 
                      :name => name, 
                      :date_of_birth => date_of_birth
                     )
      baby.parent = parent
      baby.save!
    end

    parents = nil

    #Generating sleeptimes

    babies = Baby.find(:all)

    babies.each do |baby|
      5.times do |n|
        starttime = DateTime.current - (n-2).hours
        endtime = starttime.dup + 1.hours
        sleeptime = Sleeptime.parse(starttime, endtime, baby)
        sleeptime.save!
      end
    end

  end
end