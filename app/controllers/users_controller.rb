class UsersController < ApplicationController
  def home
    @logos = SponsorLogo.to_display_on_home_page
  end

  def about
  end

  def submit_inquiry
    data = {
      name: params[:name],
      email: params[:email]
    }

    HomeMailer.send_mail(data).deliver
    redirect_to root_path(submitted: true)
  end
end
