class TracksController < ApplicationController
  helper_method :logged_in?
  helper_method :current_user

  before_action :verify_login

  def new
    @track = Track.new
    @albums = Album.all
  end

  def create
    @track = Track.new(track_params)
    @albums = Album.all

    if @track.save
      redirect_to track_url(@track)
    else
      flash.now[:errors] = @track.errors.full_messages
      render :new
    end
  end

  def show
    @track = Track.find(params[:id])
  end

  def edit
    @track = Track.find(params[:id])
    @albums = Album.all
  end

  def update
    @track = Track.find(params[:id])
    @albums = Album.all

    if @track.update(track_params)
      redirect_to track_url(@track)
    else
      flash.now[:errors] = @track.errors.full_messages
      render :new
    end
  end

  def destroy
    @track = Track.find(params[:id])
    @track.delete
    redirect_to bands_url
  end

  private

    def track_params
      params.require(:tracks).permit(:album_id, :name, :variety, :lyrics)
    end

    def verify_login
      redirect_to new_session_url unless logged_in?
    end
end
