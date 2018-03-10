class HomeMailer < ApplicationMailer
  default from: "xplodeconference@gmail.com"

  def send_mail(data)
    @data = data
    mail(to: ENV['CONTACT_EMAIL'], subject: "New Xplode Inquiry")
  end
end
