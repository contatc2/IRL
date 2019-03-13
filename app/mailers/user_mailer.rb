class UserMailer < ApplicationMailer
  def welcome_email(user)
    @user = user
    @url  = 'https://www.reallife.love'
    mail(to: @user.email, subject: "Registered", track_opens: 'true')
  end

  def registration_confirmation(user)
    @user = user
    @url  = 'https://www.reallife.love'
    mail(to: @user.email, subject: "Welcome #{@user.first_name} you just signed up!", track_opens: 'true')
  end

  def share(email, user)
    @user = user
    @url  = 'https://www.reallife.love'
    mail(to: email, subject: "#{@user.first_name} has invited you to join IRL")
  end

  def match_created(user, user2)
    @user1 = user
    @user2 = user2
    @url = 'https://www.reallife.love'
    mail(to: @user.email, subject: "Hey #{@user.first_name} you just matched!", track_opens: 'true')
    mail(to: @user2.email, subject: "Hey #{@user2.first_name} you just matched!", track_opens: 'true')
  end

  def friend_acceptation(user)
    @user = user
    @url = 'https://www.reallife.love'
    mail(to: @user.email, subject: "Hey #{@user.first_name} you have a new friend!", track_opens: 'true')
  end
end
