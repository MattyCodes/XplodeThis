class SponsorLogosController < ApplicationController
  def new
    @logo = SponsorLogo.new
  end

  def create
    @logo = SponsorLogo.new(logo_params)
    if @logo.present? && @logo.save
      redirect_to sponsor_logo_path(@logo)
    else
      @error_message = "Could not save logo, please fill all fields correctly."
      render 'new' and return
    end
  end

  def show
    find_logo_by_id_or_redirect
  end

  def destroy
    find_logo_by_id_or_redirect
    @logo.destroy
    redirect_to root_path
  end

  def edit
    find_logo_by_id_or_redirect
  end

  def update
    find_logo_by_id_or_redirect
    redirect_to sponsor_logo_path(@logo) if @logo.update_attributes(logo_params)
  end

  private

  def logo_params
    params.require(:sponsor_logo).permit(:name, :logo)
  end

  def find_logo_by_id_or_redirect
    @logo = SponsorLogo.where(id: params[:id]).first
    redirect_to root_path if !@logo.present?
  end
end
