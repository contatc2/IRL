puts "Cleans database"

Match.all.destroy_all
FriendInvitation.all.destroy_all

User.all.destroy_all

puts "Start seeding"


10.times do

user = User.new(
  first_name: Faker::Name.first_name,
  last_name: Faker::Name.last_name,
  email: Faker::Internet.email,
  date_of_birth: Faker::Date.birthday,
  password: 'secret',
  location: 'London'
)
user.remote_picture_url = 'https://images.pexels.com/photos/595747/pexels-photo-595747.jpeg?cs=srgb&dl=art-backlit-dawn-595747.jpg&fm=jpg'
user.save!

end

puts "Finish seeding"
