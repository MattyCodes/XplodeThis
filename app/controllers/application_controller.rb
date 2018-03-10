class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  protected
  def authenticate_admin_doublesecret_user!
    if admin_doublesecret_user_signed_in?
      super
    else
      redirect_to root_path
    end
  end
end
