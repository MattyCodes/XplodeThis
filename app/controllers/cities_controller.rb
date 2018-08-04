class CitiesController < ApplicationController
  before_action :authenticate_admin_doublesecret_user!, only: [:new, :create, :destroy, :edit, :update, :index]

  def index
    @cities = City.all
  end

  def new
    @city = City.new
  end

  def create
    @city = City.new(city_params)
    if @city.present? && @city.save
      redirect_to city_path(@city)
    else
      @errors = "Unable to create city - please fill all fields correctly."
      render 'new'
    end
  end

  def edit
    find_by_slug_or_redirect
  end

  def update
    find_by_slug_or_redirect
    if @city.update_attributes(city_params)
      redirect_to city_path(@city)
    else
      @errors = "Unable to update city - please fill all fields correctly."
      render 'edit'
    end
  end

  def destroy
    find_by_slug_or_redirect
    @city.destroy
    redirect_to cities_path
  end

  def show
    find_by_slug_or_redirect
  end

  def set_sponsor_logos
    @city  = City.find_by_id(params[:parentId])
    @logos = ( params[:logoIds] || [] ).map{ |id| SponsorLogo.find_by_id(id) }.compact

    if @city.present? && @city.valid?
      @city.update_attributes(sponsor_logos: [])
      @city.update_attributes(sponsor_logos: @logos)

      render json: {
        success: true,
        logos: @city.selected_and_available_logos
      }
    else
      render json: { success: false }
    end
  end

  private

  def find_by_slug_or_redirect
    @city = City.where(slug: params[:slug]).first
    redirect_to root_path if !@city.present?
  end

  def city_params
    params.require(:city).permit(:name, :day, :date, :time, :venue, :event_ticket_code, :header_image, :slug, [])
  end
end
