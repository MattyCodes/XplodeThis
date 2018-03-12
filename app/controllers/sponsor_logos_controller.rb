class SponsorLogosController < ApplicationController
  def new
    @logo = SponsorLogo.new
  end

  def create
    @logo = SponsorLogo.new(logo_params)
    if @logo.present? && @logo.save
      redirect_to root_path
    else
      @error_message = "Could not save logo, please fill all fields correctly."
      render 'new' and return
    end
  end

  def destroy
  end

  def edit
  end

  def update
  end

  private

  def logo_params
    params.require(:sponsor_logo).permit(:name, :logo)
  end
end
