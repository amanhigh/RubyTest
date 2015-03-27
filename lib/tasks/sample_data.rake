# Run using rake db:populate
# Seed Creates Admin (seeds.rb) rest of the data created by this file
namespace :db do
  task populate: :environment do
    environment = Rails.env
    unless environment=='production'
      require 'faker'
      require 'rake'
      require 'factory_girl'

      puts "Running in #{environment} environment"
      99.times do |n|
        FactoryGirl.create(:user, :name => Faker::Name.name)
      end

      100.times do
        FactoryGirl.create(:micropost, :user => User.find(1), :content => Faker::Lorem.sentence(5))
        FactoryGirl.create(:micropost, :user => User.find(rand(2..4)), :content => Faker::Lorem.sentence(5))
      end

      users = User.all
      admin = User.first
      following = users[1..50]
      followers = users[4..41]
      following.each { |followed| admin.follow!(followed) }
      followers.each { |follower| follower.follow!(admin) }

      puts 'Sample Data created'
    end
  end
end