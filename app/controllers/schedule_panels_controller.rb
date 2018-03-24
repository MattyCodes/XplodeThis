class SchedulePanelsController < ApplicationController
  before_action :authenticate_admin_doublesecret_user!

  def destroy
    @panel = SchedulePanel.where(id: params[:id])
    @panel.destroy
    redirect_to root_path
  end
end
