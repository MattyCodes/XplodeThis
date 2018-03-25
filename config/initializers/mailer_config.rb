ActionMailer::Base.delivery_method = :sendmail
ActionMailer::Base.sendmail_settings = {
  :address => "xplodeconference@gmail.com",
  :port => "587",
  :domain => "gmail.com",
  :user_name => "xplodeconference@gmail.com",
  :password => "secret",
  :authentication => "plain",
  :enable_starttls_auto => true
}
