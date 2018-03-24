class SchedulePanelsController < ApplicationController
  before_action :authenticate_admin_doublesecret_user!

  def create
    @schedule = Schedule.find_by_id(params[:scheduleId])
    redirect_to root_path if !@schedule.present?
    @panel = @schedule.schedule_panels.new(time: params[:time], title: params[:title])
    params[:speaker_ids].map do |id|
      speaker = Speaker.find_by_id(id)
      @panel.speakers.push(speaker) if speaker.present?
    end

    if @panel.present? && @panel.save
      render json: { success: true, panels: @schedule.schedule_panels }
    else
      render json: { success: false, panels: @schedule.schedule_panels }
    end
  end

  def edit
  end

  def update
  end

  def destroy
    @panel = SchedulePanel.where(id: params[:id])
    @panel.destroy
    redirect_to root_path
  end
end
