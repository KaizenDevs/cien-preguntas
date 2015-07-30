# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

100.times do |x|
  Question.create(question: Faker::Hacker.say_something_smart)
end

30.times do |x|
	User.create(email: Faker::Internet.email,password: "12345678",name: Faker::Name.first_name, lastname: Faker::Name.last_name, role: 0)
end