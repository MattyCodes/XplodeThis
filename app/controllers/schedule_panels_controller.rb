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
    @panel = SchedulePanel.find_by_id(params[:id])
    redirect_to root_path if !@panel.present?
  end

  def update
    @panel = SchedulePanel.find_by_id(params[:id])
    redirect_to root_path if !@panel.present?
    if @panel.update_attributes(panel_params)
      redirect_to ( request.referrer || root_path )
    else
      @errors = "Panel could not be updated, please try again."
      render 'edit'
    end
  end

  def add_speaker
    @speaker = Speaker.find_by_id(params[:speakerId])
    @panel = SchedulePanel.find_by_id(params[:id])
    redirect_to ( request.referrer || root_path ) if !@speaker.present? || !@panel.present?
    if @panel.speakers.push(@speaker)
      render json: { success: true, speakers: @panel.speakers }
    else
      render json: { success: false, speakers: @panel.speakers }
    end
  end

  def remove_speaker
    @speaker = Speaker.find_by_id(params[:speakerId])
    @panel = SchedulePanel.find_by_id(params[:id])
    redirect_to ( request.referrer || root_path ) if !@speaker.present? || !@panel.present?
    if @panel.speakers.delete(@speaker)
      render json: { success: true, speakers: @panel.speakers }
    else
      render json: { success: false, speakers: @panel.speakers }
    end
  end

  def destroy
    @panel = SchedulePanel.find_by_id(params[:id])
    redirect_to ( request.referrer || root_path ) if !@panel.present?
    @schedule = @panel.schedule
    if @panel.destroy
      render json: { success: true, panels: @schedule.schedule_panels }
    else
      render json: { success: false, panels: @schedule.schedule_panels }
    end
  end

  private

  def panel_params
    params.require(:schedule_panel).permit(:title, :time, [])
  end
end
