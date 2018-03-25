class HomeMailer < ApplicationMailer
  def send_mail(data)
    @data = data
    mail(to: ENV['CONTACT_EMAIL'], from: ENV['FROM_ADDRESS'], subject: "New Xplode Inquiry")
  end
end
