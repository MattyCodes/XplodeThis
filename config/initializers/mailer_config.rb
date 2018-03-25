ActionMailer::Base.delivery_method = :sendmail
ActionMailer::Base.sendmail_settings = {
  :address => ENV['FROM_ADDRESS'],
  :port => "587",
  :domain => "gmail.com",
  :user_name => ENV['FROM_ADDRESS'],
  :password => ENV['FROM_ADDRESS_PASSWORD'],
  :authentication => "plain",
  :enable_starttls_auto => true
}
