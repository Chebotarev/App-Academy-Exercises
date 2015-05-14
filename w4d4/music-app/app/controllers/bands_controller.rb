class BandsController < ApplicationController
  helper_method :logged_in?
  helper_method :current_user

  before_action :verify_login

  def index
    @bands = Band.all
  end

  def new
    @band = Band.new
  end

  def create
    @band = Band.new(band_params)
    if @band.save
      redirect_to band_url(@band)
    else
      flash.now[:errors] = @band.errors.full_messages
      render :new
    end
  end

  def show
    @band = Band.find(params[:id])
    @band_albums = @band.albums
  end

  def edit
    @band = Band.find(params[:id])
  end

  def update
    @band = Band.find(params[:id])
    if @band.update(band_params)
      redirect_to band_url(@band)
    else
      flash.now[:errors] = @band.errors.full_messages
      render :edit
    end
  end

  def destroy
    @band = Band.find(params[:id])
    @band.delete
    redirect_to bands_url
  end

  private

    def band_params
      params.require(:bands).permit(:name)
    end

    def verify_login
      redirect_to new_session_url unless logged_in?
    end
end
