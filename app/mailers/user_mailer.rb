class UserMailer < ApplicationMailer

  def welcome_email(user)
    @user = user
    @url  = 'http://example.com/login'
    mail(to: @user.email, subject: 'Welcome to My Awesome Site')
  end

  def creation_confirmation(user)
    @user = user
    mail(to: @user.email, subject: "Welcome #{@user.first_name} you just signed up!")
  end

  def share(email, user)
    @user = user
    mail(to: email, subject: "#{@user.first_name} has invited you to join IRL")
  end


end
