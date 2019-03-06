# Preview all emails at http://localhost:3000/rails/mailers/user_mailer
class UserMailerPreview < ActionMailer::Preview
  def welcome_email
    user = User.first
    UserMailer.welcome_email(user)
  end

  def creation_confirmation
    user = User.first
    UserMailer.creation_confirmation(user)
  end

  def share
    user = User.first
    email = "hello@gmail.com"
    UserMailer.share(email, user)
  end

end
