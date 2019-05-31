require 'faker'

# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

puts "emptying database"

Review.destroy_all
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
  first_name: 'Kosei',
  last_name: 'Yano',
  email: 'yano@kosei.com',
  password: "secret",
  phone_number: '03-5962-7940',
  speciality: "dentist",
  address: '1-17-14, Shibuya, Shibuya-ku, Tokyo, Japan',
  gender: "male",
  opening_hour: rand(7..10),
  closing_hour: rand(16..19),
)
doctor.remote_photo_url = "https://haplus.jp/en/imgs/shibuya/doctor/1.jpg"
doctor.save!

doctor = Doctor.new(
  first_name: 'Rei',
  last_name: 'Ishinabe',
  email: 'rei@ishinabe.com',
  password: "secret",
  phone_number: '03-1234-5678',
  speciality: "dentist",
  address: '2-11-3, Meguro, Meguro-shi, Tokyo, Japan',
  gender: "male",
  opening_hour: rand(7..10),
  closing_hour: rand(16..19),
)
doctor.remote_photo_url = "https://avatars0.githubusercontent.com/u/46408233?v=4"
doctor.save!

doctor = Doctor.new(
  first_name: 'Hanae',
  last_name: 'Morimura',
  email: Faker::Internet.email('morimura'),
  password: "secret",
  phone_number: '03-3570-1234',
  speciality: Doctor::SPECIALITIES.sample,
  address: '1-1-3, Shibuya-ku, Tokyo, Japan',
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
  address: '4-1-3 Hiroo, Shibuya-ku, Tokyo, Japan',
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
  address: '2-7-1 Tamagawa, Setagaya-ku, Tokyo, Japan',
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
  address: '1-5-1 Roppongi, Minato-ku, Tokyo, Japan',
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
  address: '1-4-1 Kasumigaseki, Chiyoda-ku, Tokyo, Japan',
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
    date: Faker::Time.between(DateTime.now-2, DateTime.now+10),
    is_confirmed: [true, false].sample
  )
  appointment.date = appointment.date.change(min: appointment.date.min < 30 ? 0 : 30)
  appointment.user = User.find(rand(User.second.id..User.last.id))
  appointment.doctor = Doctor.find(rand(Doctor.first.id..Doctor.last.id))

  # check if the current date is a weekday, if it's in the doctor's opening hours and if he already has an appointment. If there is a conflict generate new date.
  until ((1..5).include? appointment.date.wday) && ((appointment.doctor.opening_hour..appointment.doctor.closing_hour).include? appointment.date.hour) && !(appointment.doctor.appointments.find_by_date(appointment.date))
      appointment.date = Faker::Time.between(DateTime.now-2, DateTime.now+10)
      appointment.date = appointment.date.change(min: appointment.date.min < 30 ? 0 : 30)
  end

  appointment.is_confirmed = true if appointment.date < DateTime.now
  appointment.save!
end

puts "creating reviews"

User.all.each do |user|
  user.doctors.uniq.each do |doctor|
    stars = rand(1..5)
    case stars
    when 1
      content = "The doctor doesn't even speak proper English!!! Waste of time and money!!!"
    when 2
      content = "If I hadn't have my issue I wouldn't have gone here. The doctor fixed me but there is still a long way to go before making it a pleasant experience."
    when 3
      content = "It was OK, nothing much else to say. Just make sure that you are covered by insurance otherwise it can be quite a hassle."
    when 4
      content = "Japanese level care. Good doctor, nurses were also quite supportive, but some small issues here and there."
    when 5
      content = "I was in big pain, but the doctor was extremely kind, patient, and supportive. This turned the difficult situation into a positive experience. 10/10 recommend."
    else
      content = "I don't know"
    end
    review = Review.new(stars: stars, content: content)
    review.user = user
    review.doctor = doctor
    review.save!
  end
end

puts "finished"
