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
end
