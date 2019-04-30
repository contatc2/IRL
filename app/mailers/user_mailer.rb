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

  def invite(email, user)
    @user = user
    @url = 'https://www.reallife.love'
    mail(to: email, subject: "#{@user.first_name} invites you to join IRL", track_opens: 'true')
  end

  def share(email)
    @url = 'https://www.reallife.love'
    mail(to: email, subject: "A friend invites you to join IRL", track_opens: 'true')
  end

  def match_created(user, helper, intro)
    @user = user
    @helper = helper
    @intro = intro
    @url = 'https://www.reallife.love'
    mail(to: @user.email, subject: "Hey #{@user.first_name} you have a new match!", track_opens: 'true')
  end

  def match_invite(email, helper, intro)
    @helper = helper
    @intro = intro
    @url = 'https://www.reallife.love'
    mail(to: email, subject: "#{@helper.first_name} has a great match waiting for you on IRL", track_opens: 'true')
  end

  def friend_acceptation(user, friend)
    @user = user
    @friend = friend
    @url = 'https://www.reallife.love'
    mail(to: @user.email, subject: "Hey #{@user.first_name} you have a new friend!", track_opens: 'true')
  end
end
