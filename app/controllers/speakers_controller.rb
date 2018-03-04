class SpeakersController < ApplicationController
  before_action :authenticate_admin_doublesecret_user!, only: [:new, :create, :destroy, :edit, :update]

  def show
    @speaker = Speaker.where(id: params[:id])
  end

  def new
    @speaker = Speaker.new
  end

  def create
    @speaker = Speaker.create(speaker_params)
    if @speaker.present?
      redirect_to speaker_path(@speaker)
    else
      @speaker = Speaker.new(speaker_params)
      @errors = "Unable to create speaker - please fill all fields correctly."
      render 'new'
    end
  end

  def edit
  end

  def update

  end

  def index
    redirect_to root_path
  end

  def destroy
  end

  private

  def speaker_params
    params.require(:speaker).permit(:name, :title, :avatar, :email, :website, :bio, [])
  end
end
