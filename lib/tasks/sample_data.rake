require 'faker'
require 'factory_girl'

namespace :db do
  describe "Fill database with sample data"
  task populate: :environment do
    environment = ENV['RAILS_ENV=']
    unless environment=='production'
      puts "Running in #{environment} environment"
      require File.expand_path("spec/factories.rb")
      admin = FactoryGirl.create(:user)
      admin.toggle!(:admin)

      99.times do |n|
        FactoryGirl.create(:user, :name => Faker::Name.name, :email => "test#{n+1}@test.com")
      end
      puts 'Sample Data created'
    end
  end
end