class UserMailer < ApplicationMailer

  def welcome_email(user)
    @user = user
    @url  = 'https://www.reallife.love'
    mail(:to => @user.email, :subject => "Registered", :track_opens => 'true')
  end

  def registration_confirmation(user)
    @user = user
    mail(:to => @user.email, :subject => "Welcome #{@user.first_name} you just signed up!", :track_opens => 'true')
  end

  def share(email, user)
    @user = user
    @url  = 'https://www.reallife.love'
    # maybe change user for current user
    mail(to: email, subject: "#{@user.first_name} has invited you to join IRL")
    # raise
  end
end
