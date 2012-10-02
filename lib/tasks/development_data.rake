require 'faker'

namespace :db do
  desc "Fill database with development data"
  task :populate => :environment do
    Rake::Task['db:reset'].invoke
    10.times do |n|
      email  = Faker::Internet.email
      password = 'secret' << rand(1000).to_s
      User.create!( 
                    :email => email,
                    :password => password
                  )
    end
  end
end