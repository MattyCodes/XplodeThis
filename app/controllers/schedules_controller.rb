class SchedulesController < ApplicationController
  before_action :authenticate_admin_doublesecret_user!, only: [:create, :destroy, :edit, :update]

  def create
    @city = City.find_by_id(params[:id])
    redirect_to root_path if !@city.present? || @city.schedule.present?
    @schedule = Schedule.create(city_id: @city.id, slug: "#{@city.name.downcase.gsub(' ', '-') + '-schedule'}")
    if @schedule.present? then redirect_to schedule_path(@schedule) else redirect_to root_path end
  end

  def edit
    find_by_slug_or_redirect
  end

  def update
  end

  def update_panels
  end

  def show
    @schedule = Schedule.where(slug: params[:slug]).first
    redirect_to root_path if !@schedule.present?
  end

  def destroy
    find_by_slug_or_redirect
    @schedule.destroy
    redirect_to root_path
  end

  private

  def find_by_slug_or_redirect
    @schedule = Schedule.where(slug: params[:slug]).first
    redirect_to root_path if !@schedule.present?
  end

  def schedule_params
    params.require(:speaker).permit(:slug, schedule_panels: [])
  end
end
