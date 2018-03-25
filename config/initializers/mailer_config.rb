# ActionMailer::Base.delivery_method = :sendmail
# ActionMailer::Base.sendmail_settings = {
#   :address => ENV['FROM_ADDRESS'],
#   :port => "587",
#   :domain => "gmail.com",
#   :host => ENV['HOST_NAME'],
#   :user_name => ENV['FROM_ADDRESS'],
#   :password => ENV['FROM_ADDRESS_PASSWORD'],
#   :authentication => "plain",
#   :enable_starttls_auto => true
# }

ActionMailer::Base.delivery_method = :smtp
ActionMailer::Base.smtp_settings = {
     :address => "smtp.gmail.com",
     :port => 587,
     :user_name => ENV['FROM_ADDRESS'],
     :password => ENV['FROM_ADDRESS_PASSWORD'],
     :authentication => :plain,
     :enable_starttls_auto => true
}
