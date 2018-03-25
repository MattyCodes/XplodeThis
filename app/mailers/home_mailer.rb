class HomeMailer < ApplicationMailer
  default from: ENV['FROM_ADDRESS']

  def send_mail(data)
    @data = data
    mail(to: ENV['CONTACT_EMAIL'], subject: "New Xplode Inquiry")
  end
end
