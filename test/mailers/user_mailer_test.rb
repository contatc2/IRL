require 'test_helper'

class UserMailerTest < ActionMailer::TestCase
  def message
    mail(
      :subject => 'Hello from Postmark',
      :to  => 'henri@navacelle.com',
      :from => 'contact@reallife.love',
      :html_body => '<strong>Hello</strong> dear Postmark user.',
      :track_opens => 'true')
  end
end
