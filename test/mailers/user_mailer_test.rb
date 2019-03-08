require 'test_helper'

class UserMailerTest < ActionMailer::TestCase
  def message
    mail(
      :subject => 'Hello from Postmark',
      :to  => 'cac0731fa0b48a89b6bb9d12bca81e59+d995c940e34116c45b8ff67f01e6d284@inbound.postmarkapp.com',
      :from => 'contact@reallife.love',
      :html_body => '<strong>Hello</strong> dear Postmark user.',
      :track_opens => 'true')
  end
end
