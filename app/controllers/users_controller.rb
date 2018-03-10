class UsersController < ApplicationController
  def home
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
