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

user = User.new(
  first_name: Henri,
  last_name: de Navacelle,
  email: henri@navacelle.com,
  date_of_birth: 'DateTime.strptime("09/06/1978 17:00", "%m/%d/%Y %H:%M"),',,
  password: 'secret',
  location: 'London'
)
user.remote_picture_url = 'https://avatars0.githubusercontent.com/u/46580387?s=400&u=2bc93faac74e829093486a04c6ce3b11e406ed41&v=4'
user.save!

user = User.new(
  first_name: Henri,
  last_name: de Navacelle,
  email: henri@navacelle.com,
  date_of_birth: 'DateTime.strptime("09/06/1978 17:00", "%m/%d/%Y %H:%M"),',,
  password: 'secret',
  location: 'London'
)
user.remote_picture_url = 'https://avatars0.githubusercontent.com/u/46580387?s=400&u=2bc93faac74e829093486a04c6ce3b11e406ed41&v=4'
user.save!

puts "Finish seeding"
