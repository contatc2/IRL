class EmailInterceptor
  def self.delivering_email(message)
    message.subject = "#{message.to} #{message.subject}"
    message.to = [ 'paul.tetaz@yahoo.fr' ]
  end
end
