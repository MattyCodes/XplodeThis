class CitiesController < ApplicationController
  before_action :authenticate_admin_doublesecret_user!, only: [:new, :create, :destroy, :edit, :update]

  def index
    redirect_to root_path
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
    redirect_to root_path
  end

  def show
    find_by_slug_or_redirect
  end

  def add_sponsor_logo
    @city = City.find_by_id(params[:parentId])
    @logo = SponsorLogo.find_by_id(params[:logoId])

    if @city.present? && @logo.present?
      @city.sponsor_logos.push(@logo)

      render json: {
        success: true,
        currentLogos: @city.sponsor_logos.map { |sl| { name: sl.name, imageUrl: sl.logo&.url, id: sl.id } },
        availableLogos: SponsorLogo.all.select { |sl| !sl.cities.include? @city }.map { |sl| { name: sl.name, imageUrl: sl.logo&.url, id: sl.id } }
      }
    else
      render json: { success: false }
    end
  end

  def remove_sponsor_logo
    @city = City.find_by_id(params[:parentId])
    @logo = SponsorLogo.find_by_id(params[:logoId])

    if @city.present? && @logo.present?
      @city.sponsor_logos.delete(@logo)

      render json: {
        success: true,
        currentLogos: @city.sponsor_logos.map { |sl| { name: sl.name, imageUrl: sl.logo&.url, id: sl.id } },
        availableLogos: SponsorLogo.all.select { |sl| !sl.cities.include? @city }.map { |sl| { name: sl.name, imageUrl: sl.logo&.url, id: sl.id } }
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