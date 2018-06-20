class UsersController < ApplicationController
  before_action :authenticate_admin_doublesecret_user!, only: [:index, :activate]

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

    email = HomeMailer.send_mail(data)
    email.deliver_now
    redirect_to root_path(submitted: true)
  end

  def index
    @users = User.all
  end

  def activate
    user = User.find_by_id params[:id]
    if !user.present?
      redirect_to root_path
    else
      user.active!
      redirect_to users_path
    end
  end
end
