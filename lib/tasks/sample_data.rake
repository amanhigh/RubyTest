namespace :db do
  task populate: :environment do
    environment = ENV['RAILS_ENV=']
    unless environment=='production'
      require 'faker'
      require 'rake'
      require 'factory_girl'
      require File.expand_path("spec/factories.rb")

      puts "Running in #{environment} environment"
      admin = FactoryGirl.create(:user)
      admin.toggle!(:admin)

      99.times do |n|
        FactoryGirl.create(:user, :name => Faker::Name.name, :email => "test#{n+1}@test.com")
      end


      100.times do
        FactoryGirl.create(:micropost, :user => User.find(1), :content => Faker::Lorem.sentence(5))
        FactoryGirl.create(:micropost, :user => User.find(rand(2..4)), :content => Faker::Lorem.sentence(5))
      end

      users = User.all
      user = User.first
      following = users[1..50]
      followers = users[4..41]
      following.each { |followed| user.follow!(followed) }
      followers.each { |follower| follower.follow!(user) }

      puts 'Sample Data created'
    end
  end
end