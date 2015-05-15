class AlbumsController < ApplicationController
  helper_method :logged_in?
  helper_method :current_user

  before_action :verify_login

  def new
    @album = Album.new
    @bands = Band.all
  end

  def create
    @album = Album.new(album_params)
    @bands = Band.all

    if @album.save
      redirect_to album_url(@album)
    else
      flash.now[:errors] = @album.errors.full_messages
      render :new
    end
  end

  def show
    @album = Album.find(params[:id])
    @album_tracks = @album.tracks
    @band = @album.band
  end

  def edit
    @album = Album.find(params[:id])
    @bands = Band.all
  end

  def update
    @album = Album.find(params[:id])
    @bands = Band.all
    if @album.update(album_params)
      redirect_to album_url(@album)
    else
      flash.now[:errors] = @album.errors.full_messages
      render :edit
    end
  end

  def destroy
    @album = Album.find(params[:id])
    @album.delete
    redirect_to bands_url
  end

  private

    def album_params
      params.require(:albums).permit(:band_id, :name, :production)
    end

    def verify_login
      redirect_to new_session_url unless logged_in?
    end
end
