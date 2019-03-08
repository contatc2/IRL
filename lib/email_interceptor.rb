class EmailInterceptor
  def self.delivering_email(message)
    message.subject = "#{message.to} #{message.subject}"
    message.to = "cac0731fa0b48a89b6bb9d12bca81e59+d995c940e34116c45b8ff67f01e6d284@inbound.postmarkapp.com"
  end
end
