class SpeakersController < ApplicationController
  before_action :authenticate_admin_doublesecret_user!, only: [:new, :create, :destroy, :edit, :update]

  def show
    @speaker = Speaker.where(slug: params[:slug]).first
    redirect_to root_path if !@speaker.present?
  end

  def new
    @speaker = Speaker.new
  end

  def create
    @speaker = Speaker.new(speaker_params)
    if @speaker.present? && @speaker.save
      redirect_to speaker_path(@speaker)
    else
      @speaker = Speaker.new(speaker_params)
      @errors = "Unable to create speaker - please fill all fields correctly."
      render 'new'
    end
  end

  def edit
    @speaker = Speaker.where(slug: params[:slug]).first
    redirect_to root_path if !@speaker.present?
  end

  def update
    @speaker = Speaker.where(slug: params[:slug]).first
    if @speaker.update_attributes(speaker_params)
      redirect_to speaker_path(@speaker)
    else
      @errors = "Unable to create speaker - please fill all fields correctly."
      render 'edit'
    end
  end

  def index
    redirect_to root_path
  end

  def destroy
    @speaker = Speaker.where(slug: params[:slug]).first
    if @speaker.present?
      @speaker.destroy
      redirect_to root_path
    end
  end

  private

  def speaker_params
    params.require(:speaker).permit(:name, :title, :avatar, :slug, :email, :website, :bio, [])
  end
end
