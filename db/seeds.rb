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

User.create!(
    first_name: 'Paulo',
    last_name: "D'Alberti",
    email: 'paulo@dalberti.com',
    password: "secret",
    phone_number: Faker::Number.leading_zero_number(2) + Faker::Number.leading_zero_number(9)
  )

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

doctor = Doctor.new(
  first_name: 'Hanae',
  last_name: 'Morimura',
  email: Faker::Internet.email('morimura'),
  password: "secret",
  phone_number: '03-3570-1234',
  speciality: Doctor::SPECIALITIES.sample,
  address: '3-8-31 Ariake, Koto-ku, Tokyo, Japan',
  gender: "female",
  opening_hour: rand(7..10),
  closing_hour: rand(16..19),
)
doctor.remote_photo_url = "https://expatsguide.jp/wp/wp-content/uploads/cancer-institute-staff.jpg"
doctor.save!

doctor = Doctor.new(
  first_name: 'Ryo',
  last_name: 'Honda',
  email: Faker::Internet.email('honda'),
  password: "secret",
  phone_number: '03-3400-5678',
  speciality: Doctor::SPECIALITIES.sample,
  address: '4-1-22 Hiroo, Shibuya-ku, Tokyo, Japan',
  gender: "male",
  opening_hour: rand(7..10),
  closing_hour: rand(16..19),
)
doctor.remote_photo_url = "https://www.sugihori.com/img/page/staff/hayashi.jpg"
doctor.save!

doctor = Doctor.new(
  first_name: 'Keisuke',
  last_name: 'Kitahara',
  email: Faker::Internet.email('kitahara'),
  password: "secret",
  phone_number: '03-6312-1998',
  speciality: Doctor::SPECIALITIES.sample,
  address: '2-7-3 Tamagawa, Setagaya-ku, Tokyo, Japan',
  gender: "male",
  opening_hour: rand(7..10),
  closing_hour: rand(16..19),
)
doctor.remote_photo_url = "https://expatsguide.jp/wp/wp-content/uploads/Active-Ageing-Practioners.jpg"
doctor.save!

doctor = Doctor.new(
  first_name: 'Yoshiko',
  last_name: 'Nakagawa',
  email: Faker::Internet.email('ynakagawa'),
  password: "secret",
  phone_number: '03-3473-8242',
  speciality: Doctor::SPECIALITIES.sample,
  address: '5-6-8 Minami-azabu, Minato-ku, Tokyo, Japan',
  gender: "female",
  opening_hour: rand(7..10),
  closing_hour: rand(16..19),
)
doctor.remote_photo_url = "https://expatsguide.jp/wp/wp-content/uploads/Active-aging-practitioners-2.jpg"
doctor.save

doctor = Doctor.new(
  first_name: 'Taichi',
  last_name: 'Yamakawa',
  email: Faker::Internet.email('yamakawa'),
  password: "secret",
  phone_number: '080-5657-1254',
  speciality: Doctor::SPECIALITIES.sample,
  address: ' 1-4-1 Kasumigaseki, Chiyoda-ku, Tokyo, Japan',
  gender: "male",
  opening_hour: rand(7..10),
  closing_hour: rand(16..19),
)
doctor.remote_photo_url = "https://expatsguide.jp/wp/wp-content/uploads/Counselling-Tokyo.jpg"
doctor.save

doctor = Doctor.new(
  first_name: 'Ichiro',
  last_name: 'Sanno',
  email: Faker::Internet.email('ichiro_sanno'),
  password: "secret",
  phone_number: '03-3402-9987',
  speciality: Doctor::SPECIALITIES.sample,
  address: '8-10-16 Akasaka, Minato-ku, Tokyo, Japan',
  gender: "male",
  opening_hour: rand(7..10),
  closing_hour: rand(16..19),
)
doctor.remote_photo_url = "http://www.fgh-carrot.com/images/dept/doctor/masataka_hoshino.jpg"
doctor.save!

puts "creating appointments"

100.times do
  appointment = Appointment.new(
    date: Faker::Time.between(DateTime.now, DateTime.now+10),
    is_confirmed: [true, false].sample
  )
  appointment.date = appointment.date.change(min: appointment.date.min < 30 ? 0 : 30)
  appointment.user = User.find(rand(User.second.id..User.last.id))
  appointment.doctor = Doctor.find(rand(Doctor.first.id..Doctor.last.id))

  until ((1..5).include? appointment.date.wday) && ((appointment.doctor.opening_hour..appointment.doctor.closing_hour).include? appointment.date.hour)
    appointment.date = Faker::Time.between(DateTime.now, DateTime.now+10)
    appointment.date = appointment.date.change(min: appointment.date.min < 30 ? 0 : 30)
  end

  appointment.save!
end

puts "finished"
