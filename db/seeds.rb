# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

require 'faker'
require 'rake'
require 'factory_girl'

environment = ENV['RAILS_ENV=']
puts "Seeding Data in #{environment} environment"
if not User.find_by_admin(true)
  admin = FactoryGirl.create(:user, name: 'Aman', email: 'coool.aman@gmail.com', password: 'amanps', password_confirmation: 'amanps')
  admin.toggle!(:admin)
  puts "Admin Created"
else
  puts "Admin Already Exist"
end