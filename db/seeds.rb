puts "Cleans database"

Message.all.destroy_all
Match.all.destroy_all
PseudoMatch.all.destroy_all
Referral.all.destroy_all
Friendship.all.destroy_all
FriendInvitation.all.destroy_all

User.all.destroy_all

puts "Start seeding"


user = User.new(
  first_name: 'Lola',
  last_name: 'Bouton',
  email: 'Lola@bouton.com',
  date_of_birth: Faker::Date.birthday,
  password: 'secret',
  location: 'London',
  male: false
)
user.remote_picture_url = 'https://images.pexels.com/photos/595747/pexels-photo-595747.jpeg?cs=srgb&dl=art-backlit-dawn-595747.jpg&fm=jpg'
user.save!


user = User.new(
  first_name: 'Andre',
  last_name: 'Bouton',
  email: 'Andre@bouton.com',
  date_of_birth: Faker::Date.birthday,
  password: 'secret',
  location: 'London',
  male: true
)
user.remote_picture_url = 'https://images.pexels.com/photos/595747/pexels-photo-595747.jpeg?cs=srgb&dl=art-backlit-dawn-595747.jpg&fm=jpg'
user.save!


user = User.new(
  first_name: 'Henri',
  last_name: 'de Navacelle',
  email: 'henri@navacelle.com',
  date_of_birth: 'DateTime.strptime("09/06/1978 17:00", "%m/%d/%Y %H:%M")',
  password: 'secret',
  location: 'London',
  male: true

)
user.remote_picture_url = 'https://avatars0.githubusercontent.com/u/46580387?s=400&u=2bc93faac74e829093486a04c6ce3b11e406ed41&v=4'
user.save!

user = User.new(
  first_name: 'Eleonore',
  last_name: 'de Navacelle',
  email: 'eleonore@navacelle.com',
  date_of_birth: 'DateTime.strptime("09/06/1978 17:00", "%m/%d/%Y %H:%M")',
  password: 'secret',
  location: 'London',
  male: false
)
user.remote_picture_url = 'https://avatars0.githubusercontent.com/u/46580387?s=400&u=2bc93faac74e829093486a04c6ce3b11e406ed41&v=4'
user.save!

puts "Finish seeding"
