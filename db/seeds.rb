# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
require 'faker'

Faker::Config.locale = 'fr'

User.destroy_all
Event.destroy_all
Attendance.destroy_all

20.times do
  f_name = Faker::Name.first_name
  l_name = Faker::Name.last_name
  u = User.create(
    first_name: f_name, 
    last_name: l_name, 
    email: "#{f_name.downcase}.#{l_name.downcase}@yopmail.com",
    encrypted_password: Faker::Internet.password(min_length: 6, max_length: 20)
  )
end

10.times do 
  s_date = Faker::Date.forward(days: 30)
  e = Event.create(
    start_date: s_date.to_datetime,
    duration: 50,
    title: Faker::Lorem.paragraph_by_chars(number: rand(6..20)),
    description: Faker::Lorem.paragraph_by_chars(number: rand(400..1000)),
    price: rand(1..500),
    location: Faker::Lorem.word,
    organizer: User.all.sample
  )
end

40.times do
  a = Attendance.create(
    stripe_customer_id: Faker::Number.number(digits: 10),
    user: User.all.sample,
    event: Event.all.sample 
  )
end
