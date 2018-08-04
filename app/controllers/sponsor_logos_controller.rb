class SponsorLogosController < ApplicationController
  before_action :authenticate_admin_doublesecret_user!

  def index
    @logos = SponsorLogo.all
  end

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

  def home
  end

  def order_for_home_page
    ids_array = ( params[:logoIds] || [] )

    SponsorLogo.where.not(home_index: nil).map do |logo|
      logo.update_attributes(home_index: nil) if !ids_array.include?(logo.id)
    end

    ids_array.each_with_index.map do |id, index|
      logo = SponsorLogo.find_by_id(id)
      logo.update_attributes(home_index: index) if logo.present?
    end

    render json: {
      success: true,
      logos: SponsorLogo.for_home_page_json
    }
  end

  private

  def logo_params
    params.require(:sponsor_logo).permit(:name, :logo, :display_on_home_page, :link)
  end

  def find_logo_by_id_or_redirect
    @logo = SponsorLogo.where(id: params[:id]).first
    redirect_to root_path if !@logo.present?
  end
end
