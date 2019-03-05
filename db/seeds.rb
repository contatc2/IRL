# puts "Cleans database"

# User.all.destroy_all

puts "Start seeding"


10.times do

User.create!(
  first_name: Faker::Name.first_name,
  last_name: Faker::Name.last_name,
  email: Faker::Internet.email,
  date_of_birth: Faker::Date.birthday,
  picture: 'https://images.pexels.com/photos/595747/pexels-photo-595747.jpeg?cs=srgb&dl=art-backlit-dawn-595747.jpg&fm=jpg',
  password: 'secret',
  location: 'London'
  )

end

puts "Finish seeding"
