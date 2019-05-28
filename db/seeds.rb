require 'faker'

# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

puts "emptying database"

Appointment.destroy_all
User.destroy_all
Doctor.destroy_all

puts "creating users"

10.times do
  first_name = Faker::Name.first_name
  last_name = Faker::Name.last_name
  User.create!(
    first_name: first_name,
    last_name: last_name,
    email: Faker::Internet.email(first_name),
    password: "secret",
    phone_number: Faker::Number.leading_zero_number(2) + Faker::Number.leading_zero_number(9)
  )
end

puts "creating doctors"

2.times do
  first_name = Faker::Name.male_first_name
  last_name = Faker::Name.last_name
  Doctor.create!(
    first_name: first_name,
    last_name: last_name,
    email: Faker::Internet.email(first_name),
    password: "secret",
    phone_number: Faker::Number.leading_zero_number(2) + Faker::Number.leading_zero_number(9),
    speciality: Doctor::SPECIALITIES.sample,
    address: Faker::Address.full_address,
    gender: "male",
    opening_hour: rand(7..10),
    closing_hour: rand(16..19)
  )
end

2.times do
  first_name = Faker::Name.female_first_name
  last_name = Faker::Name.last_name
  Doctor.create!(
    first_name: first_name,
    last_name: last_name,
    email: Faker::Internet.email(first_name),
    password: "secret",
    phone_number: Faker::Number.leading_zero_number(2) + Faker::Number.leading_zero_number(9),
    speciality: Doctor::SPECIALITIES.sample,
    address: Faker::Address.full_address,
    gender: "female",
    opening_hour: rand(7..10),
    closing_hour: rand(16..19)
  )
end

puts "creating appointments"

10.times do
  appointment = Appointment.new(
    date: Faker::Date.forward(14),
    is_confirmed: [true, false].sample
  )
  appointment.user = User.find(rand(User.first.id..User.last.id))
  appointment.doctor = Doctor.find(rand(Doctor.first.id..Doctor.last.id))
  appointment.save!
end

puts "finished"
